From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v3] ARM: imx: Add basic imx6q thermal management
Date: Wed, 18 Jan 2012 11:56:56 +0000
Message-ID: <20120118115656.GE1068@n2100.arm.linux.org.uk>
References: <1326862087-17816-1-git-send-email-rob.lee@linaro.org> <1326862087-17816-2-git-send-email-rob.lee@linaro.org> <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34717 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2ARL5g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jan 2012 06:57:36 -0500
Content-Disposition: inline
In-Reply-To: <CAMXH7KE3CUvoZgW2UQiPLc3-oAHO0gcH4GRHU46ScyK519nvfQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: s.hauer@pengutronix.de, shawn.guo@freescale.com, amit.kachhap@linaro.org, amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On Wed, Jan 18, 2012 at 05:40:02AM -0600, Rob Lee wrote:
> > + =A0 =A0 =A0 /* In the rarest of cases, order matters here - resum=
e goes first */
> > + =A0 =A0 =A0 th_zone->therm_dev->device.class->resume =3D imx6q_th=
ermal_resume;
> > + =A0 =A0 =A0 th_zone->therm_dev->device.class->suspend =3D imx6q_t=
hermal_suspend;
> On second thought, I should have barrier between these two statements
> to guarantee order.  I think mb() would be ok.

Err, no.  This is a serious bug.

You're writing to this structure:

static struct class thermal_class =3D {
        .name =3D "thermal",
        .dev_release =3D thermal_release,
};

in thermal_sys.c, which would be shared with other thermal drivers.  Th=
is
is far from safe - it's insane.

The ordering or mb() is the least of your problems.

If there isn't suspend/resume support provided, please talk to the ther=
mal
people about how to do this.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
