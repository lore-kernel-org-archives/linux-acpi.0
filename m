From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Mon, 24 Jan 2005 23:54:49 -0500
Message-ID: <41F5D119.1000701@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu> <41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu> <41F04D5A.8060304@paranoici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F04D5A.8060304-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ultrakorne <ultrakorne-XtQPfPCVGG7srOwW+9ziJQ@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ultrakorne wrote:
> Rich Townsend wrote:
> 
>> OK, it seems like I've drifted toward doing a nightly build of the SBS 
>> driver -- and tonight is no different! The latest version of the code,
>>
>> http://shayol.bartol.udel.edu/~rhdt/download/acpi_sbs-20050119.tar.gz
>>
> 
> this works fine (no more interrupting the charge).
> at every boot, with ac ever plugged i lost 1% of the charge, the led in 
> front of the laptop is green ( full charge ) but the driver says 97%

That's because the battery won't switch the charger on until the charge 
level drops below a certain value. Also, once the battery is fully 
charged, it begins slowly to discharge again. This is because the 
battery's internal circuitry requires a small amount of power.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
