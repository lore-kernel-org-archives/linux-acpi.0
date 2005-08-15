From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [GIT PATCH] ACPI patch for 2.6.13-rc6
Date: Mon, 15 Aug 2005 16:35:59 -0400
Message-ID: <1124138159.17245.4.camel@toshiba>
References: <1122702560.26850.9.camel@toshiba>
	 <1123110985.13136.12.camel@toshiba>  <1123175479.13136.21.camel@toshiba>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1123175479.13136.21.camel@toshiba>
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
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus, please pull from: 

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-linus.git

This patch allows the platform-specific drivers, such as toshiba_acpi
and asus_acpi to run w/o any cmdline flags -- like they did in 2.6.12.

thanks,
-Len

ps. The latest ACPI patch, including this and more lives here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.12
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.13

This will update the following files:

 Documentation/acpi-hotkey.txt       |    3 +++
 Documentation/kernel-parameters.txt |    5 +++++
 drivers/acpi/osl.c                  |    6 +++---
 3 files changed, 11 insertions(+), 3 deletions(-)

through these commits:

--------------------------
commit 30e332f3307e9f7718490a706e5ce99f0d3a7b26
tree 39054cfaf058a369f2b75bd89265e83522c02b49
parent d4ab025b73a2d10548e17765eb76f3b7351dc611
author Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> 1123821060 -0400
committer Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> 1124135218 -0400

[ACPI] re-enable platform-specific hotkey drivers by default

When both platform-specific and generic drivers exist,
enable generic over-ride with "acpi_generic_hotkey".

http://bugzilla.kernel.org/show_bug.cgi?id=4953

Signed-off-by: Luming Yu <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--------------------------




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
