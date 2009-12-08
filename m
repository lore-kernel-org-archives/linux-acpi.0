From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [Resend] [PATCH] asus-laptop: add Lenovo SL LenovoCare LED
	support
Date: Tue, 8 Dec 2009 18:32:15 +0100
Message-ID: <71cd59b00912080932nf334ba7uf65c70178fec41a5@mail.gmail.com>
References: <1260257829-7343-1-git-send-email-ike.pan@canonical.com>
	 <20091208154154.GA26435@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965419AbZLHRcT@vger.kernel.org>
In-Reply-To: <20091208154154.GA26435@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Ike Panhc <ike.pan@canonical.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, Alexandre Rostovtsev <tetromino@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Dec 8, 2009 at 4:41 PM, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
> On Tue, Dec 08, 2009 at 03:37:09PM +0800, Ike Panhc wrote:
>
>> =A0ASUS_HANDLE(rled_set, ASUS_HOTK_PREFIX "RLED"); =A0 =A0 =A0/* W1J=
C */
>> =A0ASUS_HANDLE(pled_set, ASUS_HOTK_PREFIX "PLED"); =A0 =A0 =A0/* A7J=
 */
>> =A0ASUS_HANDLE(gled_set, ASUS_HOTK_PREFIX "GLED"); =A0 =A0 =A0/* G1,=
 G2 (probably) */
>
> The driver is controlling the ATKD device, which has a HID of ATK0101=
=2E
> These devices are all underneath it...
>
>> +ASUS_HANDLE(lled_set, "\\_SB_.PCI0.SBRG.EC0_.HKEY.TVLS"); /* Lenovo=
Care */
>
> And this one isn't, which is a bit jarring. Looking closer, it's unde=
r
> the LEN0014 device, which means that you're trying to touch a method
> that belongs to a device other than the one this driver is bound to.
> That's wrong. You want a separate ACPI driver for the LEN0014 device,
> and this should be called for there. Looking at it, you seem to get
> rfkill as well (the GWAN/SWAN, GBDC/SBDF and GUWB/SUWB methods) and
> maybe some other stuff.
>
> So this shouldn't go in asus-laptop. You'll need to add another separ=
ate
> driver for the SL-specific functionality.

That means asus-laptop and sl-laptop will be both needed for a SL
laptop, but I don't think this is a problem.



--=20
Corentin Chary
http://xf.iksaif.net
