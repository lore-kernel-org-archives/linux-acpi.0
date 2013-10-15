From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/Power: Check physical device's runtime pm status before requesting to resume it
Date: Tue, 15 Oct 2013 23:22:28 +0200
Message-ID: <16284735.7LFgSiThhv@vostro.rjw.lan>
References: <1381479385-1614-1-git-send-email-tianyu.lan@intel.com> <1761658.DWcBvZSdOl@vostro.rjw.lan> <525D03B4.8050709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60415 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933854Ab3JOVKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Oct 2013 17:10:39 -0400
In-Reply-To: <525D03B4.8050709@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, October 15, 2013 04:58:28 PM Lan Tianyu wrote:
> On 2013=E5=B9=B410=E6=9C=8811=E6=97=A5 19:19, Rafael J. Wysocki wrote=
:
> > On Friday, October 11, 2013 04:16:25 PM tianyu.lan@intel.com wrote:
> >> From: Lan Tianyu <tianyu.lan@intel.com>
> >>
> >> Currently, when one power resource is turned on, devices owning it
> >> will be requested to resume regardless of their runtime pm status.
> >> ACPI power resource maybe turn on in some devices' runtime pm
> >> resume callback(E.G, usb port) while turning on the power resource
> >> will trigger one new resume request of the device. It causes
> >> infinite loop between resume and suspend. This has happened on
> >> clearing usb port's PM Qos NO_POWER_OFF flag twice. This patch is
> >> to add check of physical device's runtime pm status and request re=
sume
> >> if the device is suspended.
> >>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> ---
> >>  drivers/acpi/power.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> >> index 0dbe5cd..228c138 100644
> >> --- a/drivers/acpi/power.c
> >> +++ b/drivers/acpi/power.c
> >> @@ -250,8 +250,10 @@ static void acpi_power_resume_dependent(struc=
t work_struct *work)
> >>
> >>  	mutex_lock(&adev->physical_node_lock);
> >>
> >> -	list_for_each_entry(pn, &adev->physical_node_list, node)
> >> -		pm_request_resume(pn->dev);
> >> +	list_for_each_entry(pn, &adev->physical_node_list, node) {
> >> +		if (pm_runtime_suspended(pn->dev))
> >> +			pm_request_resume(pn->dev);
> >> +	}
> >
> > This is racy, because the status may change right after you check i=
t and before
> > you call pm_request_resume().
>=20
> Yes, the runtime status may be changed just after the check.
>=20
> >
> > Besides, pm_request_resume() checks the status of the device and wo=
n't
> > try to resume it if it is not suspended.
> >
>=20
> For this issue, usb port is in the RPM_SUSPENDING state when
> pm_request_resume() is called.

Why exactly does that happen?

> The deferred_resume will be set to true
> during this procedure and trigger resume after finishing suspend. USB
> port runtime resume callback will turn on its power resource again an=
d
> the work of acpi_power_resume_dependent() is scheduled. Because the u=
sb
> port's usage count remains zero, it's to be suspended soon. When
> pm_request_resume() of acpi_power_resume_dependent() is called, the u=
sb
> port is always in the PRM_SUSPENDING. Fall in the loop of suspend and
> resume.
>=20
> How about running acpi_power_dependent when turning on power resource=
=20
> rather than scheduling a work to run it?

Is this actually going to help?  Even if acpi_power_resume_dependent() =
is
run synchronously from within the resume callback, it will still see
RPM_SUSPENDING as the device's status, won't it?

> After this, pm_request_resume() can check device's right status just =
after
> turning on power resource.

The status doesn't change until the .runtime_suspend() callback returns=
 and
running pm_request_resume() syncrhonously from that callback for the de=
vice
being suspended just plain doesn't make sense.

> Furthermore, pm_request_resume() is async resume and=20
> this change will not consume much time.

acpi_power_resume_dependent() is run from a work item to avoid locking
problems.

Can you please explain to me how this is possible that the USB port's p=
ower
resource is turned "on" while the port is RPM_SUSPENDING?

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
