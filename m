From: Stefan Baums <baums@u.washington.edu>
Subject: Re: Fw: ACPI and the idle loop - possible bug
Date: Mon, 27 Jun 2005 15:09:04 -0700
Message-ID: <20050627220904.GA6846@localhost.localdomain>
References: <20050625151923.738504b1.akpm@osdl.org> <16A54BF5D6E14E4D916CE26C9AD3057502698BE3@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD3057502698BE3-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> processor module has a parameter 'max_cstate', setting it to 2
> is a better workaround to me if you hate the noise.

Thank you very much for pointing out that option.  I am using it
now, and it is indeed a better workaround than idle=3Dhalt.

But it is a workaround.  On the one hand, it deprives me of C3 and
C4 and thus shortens my battery life.  On the other, I found it
exceedingly difficult to even find out about this option and get
it to work.  (I tried passing it to the module via
/etc/modprobe.d/ and /etc/modules, but neither one worked, and in
the end I had to compile the ACPI processor part directly into the
kernel and pass the option as a boot parameter
'processor.max_cstate=3D2'.)  But as you can see from the ThinkWiki
discussion, and Janosch=E2=80=99s post in this thread, there are indeed
quite a lot of users (of at least ThinkPads and Acer laptops) who
are affected by this problem and find the noise very unpleasant
and distracting.  As far as I remember, the noise was not there in
Windows XP on my machine (sorry, can=E2=80=99t check now, deleted
Windows), and as far as I know Windows XP does use the C3 state.
So do you think that you or the ACPI maintainers could try to
rewrite the Linux ACPI implementation so that it does not cause
this problem in C3?  I think it is not very good that on the
laptops concerned, a default Linux installation causes a constant
irritating noise and the only workaround (not solution) involves
finding the 'max_cstate' information, recompile the kernel (with
processor compiled in) and reconfigure the boot loader...  (In
case you do want to fix this and get a chance to test it out on a
ThinkPad X41: there the noise emerges from the ventilation vent on
the left-hand side of the laptop.  You may not hear it clearly in,
say, a noisy cafe or other public place, but it is very noticeable
in a quiet room.)

Finally, an unrelated problem is that ACPI apparently only honours
the idle=3Dhalt boot parameter until the first suspend/resume or
power state change, and then reenables C2 and above.

Do I need to file a separate formal bug report for these two
issues, and if so where?  Or is the discussion in this thread
sufficient for the ACPI maintainers to work with?

Best regards,
Stefan Baums

--=20
Stefan Baums
Asian Languages and Literature
University of Washington


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
