From: Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Date: Sun, 2 Jan 2005 15:32:06 -0500
Message-ID: <20050102203206.GB22295@redhat.com>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org> <m3zmzvl9x1.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0501021147260.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501021147260.2280-gWtpgVMusWVb5UGfqNBoRg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Cc: "Georg C. F. Greve" <greve-BSDwwRMYa8fNLxjTenLetw@public.gmane.org>, Hans Ulrich Niedermann <vserver-9NFtMYurFwKVLSD0ah36CQ@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Herbert Poetzl <herbert-dBHVzrDq9nF4Lj/PQRBjDg@public.gmane.org>, Nick Warne <nick-ucsffw2X/bzR7s880joybQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Jan 02, 2005 at 12:11:47PM -0800, Linus Torvalds wrote:

 > DaveJ: this may explain the "Mobile Radeon" reports. Not because of
 > anything Radeon-specific, but simply because they'd have four ports (CRT,
 > LVDS TFT panel, tv-out, and tv-in, I think - ACPI doesn't tell me enough
 > to be sure).

I think the problem biting Fedora people turned out to be a side-effect
of having the 4g/4g patch applied, but not enabled. (The affected kernels
we shipped didn't have the post-2.6.9 acpi video stuff).

		Dave



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
