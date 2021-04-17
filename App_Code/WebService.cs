using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class WebService
{
	// To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
	// To create an operation that returns XML,
	//     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
	//     and include the following line in the operation body:
	//         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
	[OperationContract]
	public Vistor getVistorByID(string id)
	{

        StatisticsReportForReferenceServicesDataContext objDataContext = new StatisticsReportForReferenceServicesDataContext();
        Vistor v = new Vistor();


        var q = objDataContext.getVistorByID(id).ToList<getVistorByIDResult>();
        foreach (var item in q)
        {
            if (item.Gender != null) v.Gender = (bool) item.Gender;
            v.Name = item.Name;
            v.NationalID = item.CivilID;
            v.Mobile = item.MobileNo;
            v.vistor_id = item.VisitorID;
        }
        return v;
	}

	// Add more operations here and mark them with [OperationContract]
}
