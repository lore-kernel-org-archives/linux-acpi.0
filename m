From: Norbert Preining <preining-DX+603jRYB8@public.gmane.org>
Subject: various problems with Acer TM654, suspend, ACAD, radeon
Date: Fri, 20 Aug 2004 18:19:11 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040820161911.GA24510@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello dear ACPI fellows!

I am using an Acer TravelMate 654LCi with debian/sid on it running
always the latest -mm kernels (ATM 2.6.8.1-mm3).

I have encountered the following problems with ACPI:

- The battery does not deliver the discharging rate, it is always 0:
	present:                 yes
	capacity state:          ok
	charging state:          discharging
	present rate:            0 mA
	remaining capacity:      2749 mAh
	present voltage:         11520 mV

- The AC adapter does not send *any* events.
	Neither when plugged in nor unplugged.

- The battery gives periodic events:
	battery BAT1 00000080 00000001
	battery BAT2 00000080 00000000
  (although there is NO battery 2 installed!)

-----------------------------------------------

No for something related to this: Suspend2XXX.

With S2D I had success up to 2.6.7-mm5 (I didn't check all the inbetween
kernels), but with 2.6.8.1-mmX and rc4-mmX the laptop suspends without
any problems (besides I have to stop mysqld), even with X running (ATI
Radeon 7500M 0000:01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon Mobility M7 LW [Radeon Mobility 7500]).

With the newer kernels resuming does not work anymore, there are many
Ooops. (I know, I should write them down on a sheet of paper, I will try
to collect them with usb-serial console).


For S2R: I got this pretty nice working, I had to stop USB, and various
other stuff, and with boot-radeon I get my console back again.

The only thing I am not getting right is X. Switching to X always makes
a hard freeze. Not even Sysrq works anymore. What I am using is
xlibmesa-dri	4.3.0.dfsg.1-6
xlibmesa-gl1-dri-trunk	2004.02.28-2
xserver-xfree86-dri-trunk	2004.02.28-2
(the last two packages are from http://people.debian.org/~daenzer/

----------------------------------------------------------------

Now my questions:
- Can the missing battery (dis)charge rate be fixed? Is this an hardware
  defect, i.e. the battery does not send the information, or are there
  other reasons?
- Same with the AC Adapter, why does it send no event at all?
- What can I try out to get S2D back again and S2R fully working?

Thanks a lot for any help and I will try to send you all the relevant
information you may ask for!


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
TODDING (vb.)
The business of talking amiably and aimlessly to the barman at the
local.
			--- Douglas Adams, The Meaning of Liff


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
