From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 3.11-rc2 [backlight] [ASUS N56VZ]
Date: Wed, 24 Jul 2013 14:05:15 -0700
Message-ID: <CA+55aFxvLox_iwPAg=iJx4F9M_FpMPY3ettFtAJOUk78d4+0pw@mail.gmail.com>
References: <BLU0-SMTP125E791F01E26C3D60D7353A6680@phx.gbl>
	<17420057.BAULu67LQ3@vostro.rjw.lan>
	<CA+55aFzDgAcrzkkq06Qe9CBbBv6xKMYwPqtwv+ACryRSTRDOSQ@mail.gmail.com>
	<20130724210200.GY5939@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130724210200.GY5939@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Aaron Lu <aaron.lu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?B?KiBTQU3DjSAq?= <miaousami@hotmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Igor Gnatenko <i.gnatenko.brain@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 24, 2013 at 2:02 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> I think a i915 module option should be doable, otoh people seem to have a
> viable workaround by setting a different acpi os version already.

At least the original claim was that if you set a non-windows8 acpi os
version, you hit other bugs..

But yeah, if we just do a plain revert, that may be the only option
for the people for whom the current (to-be-reverted) patches made
things work.

            Linus
