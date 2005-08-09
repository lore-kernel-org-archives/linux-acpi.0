From: jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: A8N-SLI Deluxe: poweroff OK with 1006 bios, fails with 1011 and later bioses
Date: Tue, 9 Aug 2005 21:40:22 +0200
Message-ID: <20050809194022.GA3289@amd64.of.nowhere>
References: <20050807064802.GA4188@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050807064802.GA4188-9lYvA+wzQ+BL6ehbpA6KYA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: jurriaan <thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Date: Sun, Aug 07, 2005 at 08:48:02AM +0200
X-XS4All-To: 
> My Asus A8N-SLI Deluxe motherboard doesn't power off when shutting down
> with a bios later than the original 1006.
> 
> I would like to use a newer bios, since they support X2 chips, for
> example.
> 
> I have decompiled the 1006 dsdt and the 1011 dsdt, and somewhere there
> must be a difference that causes this.
> 
> I've tried to read the acpi specification to find out where I should
> start, but I'm not getting it. What parts in the dsdt have to do with
> powering off the system? Where do I look?
> 
For the record (and for future google searchers, this is a popular
motherboard), recompiling the dsdt into the kernel after fixing a number
of compilation errors fixed this, both for bios version 1007 and for
1013-002, so I'm confident it's the fixing of the dsdt that's important
here.

Jurriaan
-- 
"I know what that cost you," the Serra continued. "And I understand the
price you pay to bear it thus."
"You did not, when last we met."
"No. And I would have cursed you. Or killed you. I cannot yet, with grace,
thank you for my life."
	Michelle West - The Sun Sword
Debian (Unstable) GNU/Linux 2.6.13-rc5-mm1 5505 bogomips load 0.88


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
