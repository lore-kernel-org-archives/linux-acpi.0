From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: lid state reported incorrectly; no ac events
Date: Fri, 25 Jul 2003 13:58:53 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E97081@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Fedor Karpelevitch [mailto:fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org]=20
> so state!=3D0 is interpreted as "open" whereas (it seems to me)=20
> since it=20
> is state of the _button_ (not the lid itself), it would be logical=20
> that state!=3D0 means that button is depressed (which means that the=20
> lid is closed). Am I making sense here?=20
> The only question here is what happens on other laptops or whether=20
> this is specified in ACPI docs somewhere?

10.3.1 _LID
Evaluates to the current status of the lid.
Result Code:
Zero: The lid is closed
Non-zero: The lid is open

> The other question (issue?) I have is that in acpid log I only see=20
> messages for power and lid buttons and the battery (BTW when exactly=20
> do these fire? is it only when battery is critically low/fully=20
> charged or more often?). I expected to see AC connected/disconnected=20
> events and maybe thermal events too. When I compile with acpi=20
> debugging output I do see messages on ac plugging/unplugging so I=20
> assume it gets detected correctly, but event does not fire. Is that=20
> ok or is it a bug?

Probably just not handled by acpid.

> And the last one. Is there any reason why events when lid is closed=20
> and opened are identical. It would be more convinient if they were=20
> distinct. Of course one can always read lid state on event, but=20
> having event provide that info would be handy.

I think the current way is a little more flexible.

Regards -- Andy


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
