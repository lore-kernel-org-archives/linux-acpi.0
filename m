From: Thorsten Leemhuis <fedora-rCxcAJFjeRkk+I/owrrOrA@public.gmane.org>
Subject: DSDT in Initrd-Patch (was Re: ACPI trouble in SHG 4000
	notebook)
Date: Mon, 10 Oct 2005 13:06:43 +0200
Message-ID: <1128942403.2720.100.camel@thl.ct.heise.de>
References: <62093.84.48.53.145.1128599474.squirrel@84.48.53.145>
	 <43455C54.5040309@suse.de>
	 <60067.84.48.56.10.1128651400.squirrel@84.48.56.10>
	 <43465ED1.2090505@suse.de>
	 <59137.84.48.53.17.1128726076.squirrel@84.48.53.17>
	 <434A4491.7010308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <434A4491.7010308-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Am Montag, den 10.10.2005, 12:38 +0200 schrieb Thomas Renninger:
> foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org wrote:
> >> foolish-joSiycWv2dg+3ClZCHpbBg@public.gmane.org wrote:
> >>> Here's the acpidmp output. Thanks for taking interest.
> >> Do you know how to overwrite your DSDT?
> >>Thanks so much for this. I'm using Fedora Core 4 and I will need to
> > recompile my kernel with the neccessary patches to do this. I'm not quite
> > sure how though. If you could I would greatly appriciate instructions with
> > as much detail as possible, Thanks again for your help.
>
> Posting on acpi-devel again, others might also want to know this ...
> Maybe it is also possible to attach the DSDT to the initrd for Fedora kernels. 

No, it is not. They don't want to integrate to many patches and say "Get
this merged upstream".

See:
https://www.redhat.com/archives/fedora-test-list/2005-September/msg00291.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169014

@Len Brown: Any chance the opinion you stated here
http://sourceforge.net/mailarchive/message.php?msg_id=9175150
changed? To quote Len's mail:

>  [...] 
>  Distros should absolutely never
>  be in the business of supporting hardware running modified firmware.

>  I think that one major Distro pulled the dsdt-in-initrd patch, and I
>  think it was a mistake for them to do so -- they can"t support it.

You probably meant Suse. But according to
http://www.ubuntuforums.org/showpost.php?s=8dcb4899532d6880b7a603058b844170&p=256365&postcount=2
and
http://www.wu-wien.ac.at/usr/vw8/creyes/samsungx10/samsungx10xtc1300.html
Ubuntu und Mandriva integrate it also these days. 

>  That said, it is useful for developers to be able to override the DSDT.
>  There are two methods -- re-build kernel or re-build kernel and also
>  modify the initrd.

>  Kernel re-build is (I think) simple enought.

IMHO it ist not. It costs to much time and you have to repeat it
everytime a security-related bug in the kernel is fixed. 

>   I think the patch at hand
>  takes it from simple to trivial.
>  
>  Kernel re-build + initrd update I dislike because it depends on the
>  existence of an initrd (not everybody uses has an initrd, I haven"t used
>  an initrd in over a year)
> [...]
Most (all?) major Distributions do that these days afaik.

CU
thl



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
