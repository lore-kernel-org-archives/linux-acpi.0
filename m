From: Justin Georgeson <justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: problems with DSDT
Date: Sat, 26 Mar 2005 10:32:16 -0600
Message-ID: <62c1cd27050326083278e2a961@mail.gmail.com>
Reply-To: Justin Georgeson <justin.georgeson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

I have a Dell Inspiron 2600 (BIOS rev A08) and am having problems with
ACPI. I'm quite certain the DSDT needs fixing, but don't seem to be
doing an adequate job of it. I was able to get rid of all the
compilation errors, but using the initrd patch (which is part of the
current default kernel in Ubuntu now!) I get this in /var/log/messages

Mar 26 10:10:12 localhost kernel: ACPI: Looking for DSDT in initrd...
found (at offset 4603924)!
Mar 26 10:10:12 localhost kernel:  found customized DSDT with 6374 bytes!
Mar 26 10:10:12 localhost kernel: ACPI: Using customized DSDT
Mar 26 10:10:12 localhost kernel:     ACPI-0345: *** Error: Could not
allocate table memory for [DSDT] length AAC3BAA

I DSDT at http://acpi.sourceforge.net/dsdt/index.php for this
laptop/BIOS is the one I made, in case someone wants to disassemble it
and take a look.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
