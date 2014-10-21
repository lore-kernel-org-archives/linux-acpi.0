From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v6 00/12] Add ACPI _DSD and unified device properties support
Date: Tue, 21 Oct 2014 23:08:59 +0200
Message-ID: <13750506.S2yVlRRDa2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <darren.hart@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Hi Everyone,

This is version 6 of the unified device properties interface patchset.

The original cover letter from Mika is here:

http://marc.info/?l=devicetree&m=141087052200600&w=4

and my cover letters for previous iterations are at:

http://marc.info/?l=linux-acpi&m=141212903816560&w=4
http://marc.info/?l=linux-kernel&m=141354745011569&w=4

There are a few changes with respect to v5 and the affected patches are
[02-03/12] and [09-12/12].  The remaining ones have not been modified.

Most importantly, requesting the first element of a list (package) property
from _DSD is now equivalent to accessing a single-value property of the
same type, so device_property_read_u8(dev, pname, val) will now be equivalent
to device_property_read_u8_array(dev, pname, val, 1), for example.
Consequently, this _DSD definition:

Name (_DSD, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
        Package () {"blah", "A string"},
    }
})

can be used instead of

Name (_DSD, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
        Package () {"blah", Package () {"A string"}},
    }
})

and the code will be able to retrieve the property value from the both of
them just fine.

This means, among other things, that accessors for single-value properties
can be implemented in terms of the analogous "array" property accessors
which allows the code size to be reduced somewhat.

Patches [02/12] and [09/12] have been modified to achieve that and patch
[03/12] have been modified accordingly for the "compatible" property in
_DSD to behave in an analogous way.  Additionally, the bodies of the
numerical property accessors in patches [02/12] and [09/12] are now
generated using macros (string property accessors have slightly different
rules and are simply open coded for that reason).

Patch [10/12] has been modified to drop function arguments that happened to
have the same values for both of the current users of those functions and
patches [11-12/12] have been modified to take that change into account.  If
the code in question needs to be made more complex in the future, there
should not be any problems with that.

Due to the nature of the changes I have retained all ACKs except for the
Grant's Reviewed-by on patch [03/12] (if that had been Acked-by, I would have
retained it too, but that didn't feel appropriate for the "reviewed by" thing
to me).  If any of you think that the ACKs are not applicable any more, please
let me know and I'll drop them.

Finally, many thanks to Mika for testing the series on MinnowBoard 1 and
MinnowBoard Max.  In case anybody else would like to test it, it is available
from the device-properties branch of the linux-pm.git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git device-properties

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
