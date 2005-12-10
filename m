From: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] EC Burst
Date: Fri, 9 Dec 2005 21:48:01 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30055EB0CD@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Johannes Engel <j-engel-Mmb7MZpHnFY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This should be addressed already
by the fix to 4980 and the enabling of EC interrupt mode by default.
BTW. it is now called "ec_intr" rather than "ec_burst".

This fix has been in the ACPI git tree since Monday
and should appear in the next mm tree.

http://www.kernel.org/git/?p=3Dlinux/kernel/git/lenb/linux-acpi-2.6.git;a=
=3Dcommit;h=3D7f836e502c7bfc1e0ce3df69df21b2ddfded595b

cheers,
-Len

>-----Original Message-----
>From: Dave Jones [mailto:davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]=20
>Sent: Friday, December 09, 2005 5:58 PM
>To: Johannes Engel
>Cc: Brown, Len; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [ACPI] [PATCH] EC Burst
>
>On Fri, Dec 09, 2005 at 09:15:34AM +0100, Johannes Engel wrote:
> > Hi Len!
> >=20
> > Asking the developers at SuSE about my problem they sent me=20
>to you. So
> > here I am. :)
> > With the standard kernel my laptop delays the recognition=20
>of ACPI events
> > seemingly using a queue of length 8. I found a patch some weeks ago
> > which corrects that problem. If it can help others, too,=20
>maybe you can
> > put it to the mainline. You will find details under
> > http://bugzilla.kernel.org/show_bug.cgi?id=3D5713.
>
>FWIW, we've had a number of Fedora users reporting similar problems
>(Things like battery status applets not updating and the like).
>
>Though we've got the upstream default of ec burst being disabled there.
>
>
>		Dave
>
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
