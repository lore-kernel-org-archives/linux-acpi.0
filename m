From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 18 Jan 2005 10:46:21 -0500
Message-ID: <41ED2F4D.6040703@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	 <1105747983.7368.3.camel@tyrosine>	 <47e0449d05011419037877f931@mail.gmail.com>	 <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>	 <41EBE769.7050107@arrakis.dhis.org>  <41EC6829.1070901@bartol.udel.edu> <1106046662.7368.22.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1106046662.7368.22.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Matthew Garrett wrote:
> On Mon, 2005-01-17 at 20:36 -0500, Rich Townsend wrote:
> 
> 
>>But I'm not sure why this is happening with the revised version of the 
>>code (20050116); this version contains #ifndef directives to prevent the 
>>legacy interfaces being compiled in if they are already in the kernel. 
>>Are you sure your kernel configuration matches your currently-running 
>>kernel?
> 
> 
>>From a distribution point of view, it would be nice to:
> 
> a) Not have to rewrite every acpi battery applet to use the sbs
> interface directly, and
> b) Not have to have a database of hardware that has a smart battery
> 
> Is there any way to provide the legacy interface even if standard
> battery support is built in, or alternatively some way of probing the
> system to determine which battery module should be loaded?

We can't have the legacy interface (/proc/acpi/battery) if standard 
battery support is built in, since standard battery support *defines* 
the legacy interface! The legacy interfaces in acpi-sbs only exist to 
fake the existence of a standard (i.e., control method, CM) battery.

Regarding auto-loading of the correct module, it is likely that at some 
point in the future there may be some sort of merge between the SBS work 
done by myself and Bruno Ducrot, and the standard battery code 
battery.c. This will involve quite a bit of design effort, since the 
ACPI spec considers SBS and CM batteries to be totally different beasts 
(I don't know why they didn't define a unified interface for batteries).

But at the moment we're still at the phase of getting the SBS system 
working properly.

cheers,

Rich


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
