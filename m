From: joeyli <jlee@suse.com>
Subject: Re: [PATCH] ACPI: Disable Windows 8 compatibility for some Lenovo
 ThinkPads
Date: Mon, 22 Apr 2013 10:18:22 +0800
Message-ID: <1366597102.23707.92.camel@linux-s257.site>
References: <1360599681-24781-1-git-send-email-seth.forshee@canonical.com>
	 <5158E8A0.3050904@intel.com> <20130401130340.GA3269@thinkpad-t410>
	 <515AA007.1050305@intel.com> <20130402130000.GA12381@thinkpad-t410>
	 <515BD48B.7000901@bjencks.net>  <5170B6ED.2040408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54670 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab3DVCTh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Apr 2013 22:19:37 -0400
In-Reply-To: <5170B6ED.2040408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Ben Jencks <ben@bjencks.net>, Seth Forshee <seth.forshee@canonical.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

=E6=96=BC =E4=BA=94=EF=BC=8C2013-04-19 =E6=96=BC 11:15 +0800=EF=BC=8CAa=
ron Lu =E6=8F=90=E5=88=B0=EF=BC=9A
> On 04/03/2013 03:04 PM, Ben Jencks wrote:
> > On 04/02/2013 09:00 AM, Seth Forshee wrote:
> >> On Tue, Apr 02, 2013 at 05:08:23PM +0800, Aaron Lu wrote:
> >>>
> >>> I really wondered, how Windows handled this, it should have the s=
ame
> >>> problem, unless they are not using the acpi video interface?
> >>
> >> I can only guess.
> >>
> >> I think I remember reading that Windows 8 does smooth backlight
> >> transitions, so it may well hit every intermediate brightness valu=
e.
> >> Lenovo could also be supplying a driver which rounds values to the
> >> nearest working value or uses some other interface or something el=
se.
> >=20
> > Just checked; Windows 8 doesn't use the ACPI interface. It seems to=
 have
> > access to at least 100 distinct brightness levels.
>=20
> I just came across a document on win8 backlight control, it has words
> like this:
> "
> In Windows 8, the primary mechanism by which a platform should expose
> its display brightness control functionality is the Windows Display
> Driver Model (WDDM) miniport Device Driver Interfaces (DDI).
> "
> So looks like, on win8, ACPI interface is not used for these systems.
>=20
> The link for the document is here:
> http://msdn.microsoft.com/en-US/library/windows/hardware/jj159305
>=20
> -Aaron
>=20

Per WDDM document, OEM/ODM should keep the ACPI methods (_BQL, _BCM,
_BQC) available for compliant to the OS that doesn't support WDDM, e.g.
XP, Vista.

But, I discussed with Acer for this situation at last year, they didn't
force their ODM do test ACPI compatibility. They only test through
Windows 8 UI with Fn keys.


Thanks a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
