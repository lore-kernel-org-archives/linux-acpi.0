From: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ERROR - Could not suspend device 0000:00:1d.7: error -5
Date: Mon, 7 Mar 2005 09:36:15 +1100
Message-ID: <9ed79ee00503061436228f66c2@mail.gmail.com>
References: <9ed79ee0050306042055f815bb@mail.gmail.com>
	 <200503061625.25161.destynova@esatclear.ie>
Reply-To: boltmelots <boltmelots-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200503061625.25161.destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, =?ISO-8859-1?Q?Ois=EDn_Mac_Fheara=ED?= <destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi:
Thank you very much for your reply.
As you said I removed ehci_hcd and uhci_hcd from the running modules and tr=
ied,=20
'echo standby > /sys/power/state' : This I assume worked because all i
see on the screen is:
Stopping tasks:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D|
But trying to resume the thing is a problem, it produces a bunch of
errors that i have no idea what it means.  I have to manually reboot
the computer, because it freezes.  How can I extract the errors?  I
think I will write them down on paper :-S

I also tried 'echo mem > /sys/power/state', and that works too.  But
on resume the screen is blank.  No idea what is happening!

Dam, microsoft makes it look so easy!!

Thanks again for replying.

Kind Regards,
--
Setu.


On Sun, 6 Mar 2005 16:25:25 +0000, Ois=EDn Mac Fheara=ED
<destynova-iUB+o6dfpG8i1yMB4YHZDQ@public.gmane.org> wrote:
> On Sunday 06 March 2005 12:20, boltmelots wrote:
> >=3D=3D=3D=3D=3D=3D=3D| Badness in hcd_unlink_urb at drivers/usb/core/hcd=
.c:1243
>=20
> Why don't you try unloading some of the usb modules before suspending?
> I do "/sbin/rmmod uhci_hcd" beforehand in my script, as this one used to =
cause
> some problems.
> It looks like you might want to rmmod ehci_hcd, by the entries in the log=
.
>=20
> Ois=EDn
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
