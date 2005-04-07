From: Valentine Sinitsyn <Valentine.Sinitsyn-lD3gN07P50w@public.gmane.org>
Subject: wakeup devices configuration
Date: Thu, 7 Apr 2005 14:31:40 +0600
Message-ID: <738914040.20050407143140@usu.ru>
Reply-To: Valentine Sinitsyn <Valentine.Sinitsyn-lD3gN07P50w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi all,

My question may sound silly, but I'm very new to ACPI (although not for
Linux :-): Is there any means to specify wakeup devices? I have a
laptop (it is pretty close to ECS A530) and the only way to bring it
up after standby (S1 sleep state) is pressing power button. Keyboard
and mouse events are ignored. I'm using kernel 2.6.11 and have only two
wakeup devices in /proc/acpi/wakeup: MC9 and LAN, both disabled. As one can see,
PS2K, PS2M or something like this are not among them. I'm using AMI
DeskNote BIOS (12/05/2003) which also does not seem to have any options
for wakeup devices (I'm comparing this with my desktop computer with
Award BIOS. It has explicit menus like "Wake up on LAN: Yes/NO"). Does
this mean that I'm unable to wakeup on keyboard/mouse, at least until I
upgrade my BIOS? Thanks in advance.

Valentine





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
