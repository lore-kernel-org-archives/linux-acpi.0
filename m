From: Benjamin Schindler <bschindler-oe7qfRrRQfdfcPYw/2PL0g@public.gmane.org>
Subject: Standby and Suspend-to-ram
Date: Thu, 09 Dec 2004 18:37:57 +0100
Message-ID: <1102613877.15033.6.camel@234-27-251-64.serverpronto.com>
Reply-To: bschindler-oe7qfRrRQfdfcPYw/2PL0g@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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

Hi

I've got a IBM Thinkpad T42 and I've already got Software-Suspend2
working, but suspend and suspend-to-ram wouldn't work.
I'm working with a 2.6.9-gentoo-r9 kernel (Though I'm trying in parallel
with a very henimal vanilla 2.6.9)
First, before I do any suspend, I unload all modules, so I don't get a
conflict there. I've got standby working once... but it stayed once: As
soon the screen blanks, it wakes back up. I unloaded all the
usb-modules. I heard they could cause problems. 
Also, suspend-to-ram wouldn't do... I can enter the sleep-state
perfectly, no problem there. However, when resuming, the computer seems
to start, but the screen stays blank, no matter whether xorg is started
or not. With my minimal-vanilla kernel, I get a different thing however:
The resume procedure would start (See harddisk-activity), but the
computer then suddenly dies (A kernel panic?) I'll try again with
minimal vanilla, but that's all I have been able to produce.
Any way to fix this? (I've got programming experience, so just tell me
what you want me to do ;))

Thanks
Benjamin Schindler

P.s. I'm not subscribed to this list, so would you mind CC'ing me?
Thanks



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
