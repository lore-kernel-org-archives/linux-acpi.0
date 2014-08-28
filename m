From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] Mailbox: Add support for PCC mailbox and channels
Date: Thu, 28 Aug 2014 11:10:25 +0100
Message-ID: <20140828101025.GL17528@sirena.org.uk>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
 <1409081738-5602-2-git-send-email-ashwin.chaugule@linaro.org>
 <20140827102708.GW17528@sirena.org.uk>
 <CAJ5Y-eak9A14z3im_5sgvnqMQDRf5rNgcQNGwDV2aYh_POkLOA@mail.gmail.com>
 <20140827190902.GR17528@sirena.org.uk>
 <CAJ5Y-eYk1zq+NvPRbZanO5yXVLqZ6_81rQMd+7iRtLu6HBQ5OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pR/aR/1Pn8Pa3beE"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37553 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445AbaH1KKh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2014 06:10:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJ5Y-eYk1zq+NvPRbZanO5yXVLqZ6_81rQMd+7iRtLu6HBQ5OA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--pR/aR/1Pn8Pa3beE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2014 at 05:49:53PM -0400, Ashwin Chaugule wrote:
> On 27 August 2014 15:09, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Aug 27, 2014 at 09:07:15AM -0400, Ashwin Chaugule wrote:

> > The messiness is orthogonal to my comment here - either it's legal to
> > request a mailbox without a device or it isn't, it shouldn't depend on a
> > random kernel configuration option for a particular mailbox driver which
> > it is.

> Fair enough. This was just to show that PCC is unfortunately not a
> good candidate as a generic mailbox controller.

That seems to be a very big leap...

> >> "device" out of something that isn't. The PCCT, which is used as a
> >> mailbox controller here, is a table and not a peripheral device. To
> >> treat this as a device (without faking it by manually putting together
> >> a struct device), would require adding a DSDT entry which is really a
> >> wrong place for it. Are there examples today where drivers manually
> >> create a struct driver and struct device and match them internally?
> >> (i.e. w/o using the generic driver subsystem)

> > Arguably that's what things like cpufreq end up doing, though people
> > tend to just shove a device into DT.  Are you sure there isn't any
> > device at all in ACPI that you could hang this off, looking at my
> > desktop I see rather a lot of apparently synthetic ACPI devices with
> > names starting LNX including for example LNXSYSTM:00?

> Those are special HIDs defined in the ACPI spec and none of those can
> be used to back a device for the PCCT itself, since they're unrelated
> to the PCC protocol. The PCCT is defined in the spec as a separate
> table and if supported, should be visible in your system in the
> PCCT.dsl file. Just for the sake of the Mailbox framework, trying to
> represent the PCCT (which is a table) as a mailbox controller device,
> would require registering a special HID. That in turn would make an
> otherwise OS agnostic thing very Linux specific.

OK, but then there's always the option of just having some code that
runs on init and instantiates a device if it sees the appropriate thing
in the ACPI tables in a similar manner to how HIDs are handled.  It's a
small amount of work but it will generally make life easier if there is
a struct device.

> > If PCC is described by ACPI tables how would non-ACPI users be able to
> > use it?

> Whoever wants to do that, would need to come up with DT bindings that
> describe something similar to the PCCT contents. They could possibly
> ignore the ACPI specific bits like signature, asl compiler details
> etc. (which are only used by ACPI table parsers) and provide the rest
> of it. Its essentially an array of structures that point to various
> shared memory regions, each of which is owned by a PCC client and
> shared with the firmware. The intercommunication between client and
> firmware is via a doorbell, which is also described in these entries
> and can be implemented as an SGI or similar.

Of course most likely such a binding would involve creating a device
that owns the mailboxes so this'd be fairly straightforward...

--pR/aR/1Pn8Pa3beE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/wAOAAoJELSic+t+oim9hKUQAJbc9rKk1gCAylbhwFtW7TME
leMu73RxaVuXRb3G/6QHD3bLq41lO2+2l3Wa1T40y8FCyL00LqOmfmbVONdHCRKK
Yq50+bj1GDsFRdIps2AORLEy0NIcVFxSpAjEuWLDsc2jXwEzn0LDuZcgIOXmu78W
I7LbjNO9dvnRnO1qgCdgL1mjOGYLF+P12Kt80QEtSw3a7RJrmbdleXXOVbQGF7MI
E2e4EC/kxRrvsg9Ls9vdMg2XQG0MCSTzgqaAWOlO8MqdegytN3RG+Ou2Tsc6DU6I
BG39zia8Jjme+UezDPgu/FNBmAvFaJ/IbuyePrnezS9xVIqPX/M3rCVD6ZJ5dGA/
Uz5EgovytnrDObCuceF4NmjmGeffCq1mLCwc0olzcvjd90WjlHskS6i572G+N65z
93fy5IsrKHj9AhMEgsQiuss+SqcagrzBv8A0wxZES7/a0n64KfeSMydNhLhO297O
Q/il/lrocpUnnto3/ZzkKyhwieWuzoSkfiizmARGjOFoAXcalWsRlhSxAfKHkOcD
BX+atE8Yn7vFaJ8bUPccIgdjoXl3+DwRvxDUGeutBAcZm/SUNjhyIqpKw1CjJXJq
WJFbDW0i5BWnG+Wkf1EA24jAQKm4Y/0AW4738DQU7e2tTyzt+ITbgHx23NGh4uaY
Yqxh6gE4CKLH1AFwC9X/
=oFsI
-----END PGP SIGNATURE-----

--pR/aR/1Pn8Pa3beE--
