From: Richard Witt <witt-IGkKxAqZmp0@public.gmane.org>
Subject: AC adaptor state change lockup on HP Pavilion zt1290
Date: Mon, 03 Jan 2005 10:32:40 -0500
Message-ID: <41D96598.3040102@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi All,

   I have a terribly annoying problem that I have so far been unable to 
fix.  I'm running SuSE 9.2 Pro on a HP zt1290.  The kernel is their most 
up-to-date (2.6.8-24.10-default).  Whenever I need to connect/disconnect 
my AC adaptor the laptop locks-up hard.  I have to cold boot to recover 
it.  I thought this was related to a buggy DSDT and so I attempted to 
fix the DSDT according to the info at 
(http://www.cpqlinux.com/acpi-howto.html#fix_broken_dsdt).  The DSDT now 
compiles without errors or warnings.  It is found and loaded properly in 
the initrd as you can see here:

--clip--
ACPI: Looking for DSDT in initrd... found at offset 1195404
ACPI: Using customized DSDT
    tbget-0291: *** Info: Table [DSDT] replaced by host OS
ACPI: IRQ9 SCI: Edge set to Level Trigger.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 1186k freed
--clip--

Unfortunately the problem remains.  I'm really desperate to fix this 
since I'm sure you can imagine what a pain it is to have to shutdown and 
reboot anytime I need to move the laptop.  Does anyone have any 
suggestions how to proceed with debugging this problem?

Thanks,
   Richard


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
