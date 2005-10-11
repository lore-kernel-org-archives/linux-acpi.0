From: Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Using the SLPB button for MEM state (suspend to ram)
Date: Tue, 11 Oct 2005 14:07:44 +1000
Message-ID: <17227.14992.805411.577485@cse.unsw.edu.au>
References: <BAYC1-PASMTP03F4CB11CD595EA2BC0C07D6780@CEZ.ICE>
	<434B2D21.1090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: message from Petros Kolyvas on Monday October 10
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Petros Kolyvas <pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Monday October 10, pkolyvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> Hi folks,
> 
> I've been using ACPI4Linux's suspend to RAM for some time. Until a
> recent reinstall of gentoo, I had been using the lid button (LID0), and
> a script which polled its state (/proc/acpi/button/lid/LID0/state) and
> consequently, depending on whether the lid was up or down, the laptop
> would either come out of or go into the "mem" state.

That's an interesting approach.
I use acpid which monitors /proc/acpi/events and runs various scripts
in /etc/acpi/events when things happen.

> 
> I noticed that the Sleep Button, (/proc/acpi/button/sleep/SLPB) is
> present but that there is no state (/proc/acpi/button/sleep/SLPB/state)
> to poll in a script and therefore I'm unsure if I can use the button at
> all.

SLPB doesn't have a state because it is edge-triggered, not level
triggered.
It causes an action as you press it.  Holding the button down, or
releasing it, aren't interesting at all.
This contrasts with LID0 which is a level.  It tells you whether the
lid is open or closed.  There are two states and both are interesting.

> 
> If anyone has any idea on how to possibly use this button, if it can be
> used, or if there's a HOWTO out there that I missed, I'd greatly
> appreciate it.
> 

Looking into acpid.

NeilBrown


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
