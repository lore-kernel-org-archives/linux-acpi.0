From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay
	light in S3 mode stays on
Date: Mon, 11 Apr 2005 21:32:34 +0100
Message-ID: <1113251554.10110.60.camel@tyrosine>
References: <20050411201741.73077.qmail@web88002.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050411201741.73077.qmail-U/uKf82u23SB9c0Qi4KiSl5cfvJIxWXgQQ4Iyu8u01E@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-04-11 at 16:17 -0400, Shawn Starr wrote:
> Sure, I suppose you can, but most suspend tools just
> echo stuff to /sys (or still /proc/acpi/sleep) which
> makes it harder to script it. Besides, when a laptop
> goes into suspend to RAM there should be no extra
> power   on except a Moon or some other icon.

Most suspend tools are depressingly stupid. That's not a good reason to
push functionality into the kernel. The vast majority of hardware won't
work with that approach at the moment.

> That said, the ACPI thinkpad extras was designed to do
> all of this so why shouldn't the driver do S3 suspend
> if it hooks into it already?

Because, well, strictly it wasn't. The LED control functionality in the
IBM-acpi code exists because it exposes methods that are used by the
BIOS in normal usage. It gives some degree of extra flexibility -
there's no point in removing that for the sake of having one fewer line
of shell in a suspend script. I might want the LEDs to be in different
states depending on what triggered the suspend.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
