From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Tue, 18 Jan 2005 11:11:02 +0000
Message-ID: <1106046662.7368.22.camel@tyrosine>
References: <41E81C2C.8010809@bartol.udel.edu>
	 <1105747983.7368.3.camel@tyrosine>
	 <47e0449d05011419037877f931@mail.gmail.com>
	 <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu>
	 <41EBE769.7050107@arrakis.dhis.org>  <41EC6829.1070901@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EC6829.1070901-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-01-17 at 20:36 -0500, Rich Townsend wrote:

> But I'm not sure why this is happening with the revised version of the 
> code (20050116); this version contains #ifndef directives to prevent the 
> legacy interfaces being compiled in if they are already in the kernel. 
> Are you sure your kernel configuration matches your currently-running 
> kernel?

>From a distribution point of view, it would be nice to:

a) Not have to rewrite every acpi battery applet to use the sbs
interface directly, and
b) Not have to have a database of hardware that has a smart battery

Is there any way to provide the legacy interface even if standard
battery support is built in, or alternatively some way of probing the
system to determine which battery module should be loaded?

Thanks,
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
