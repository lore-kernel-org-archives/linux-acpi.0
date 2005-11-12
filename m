From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Samsung P35, video and S3 (suspend-to-RAM) solution
Date: Sat, 12 Nov 2005 03:11:05 +0100
Message-ID: <43754F39.6030804@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

for the last 6 months a patch I developed for radeonfb has been used on 
my Samsung P35 machine to resume from suspend-to-RAM and has not failed 
once.

Advantages of the patch:
- Does not need X to resume
- Does not need any kernel parameter
- Will not conflict with a running X
- Gives you full 1400x1050 native framebuffer support
- Does not need vbetool or any other VESA POST tool
- Survived 441 (yes, I counted) suspend cycles without any problem

Disadvantages of the patch:
- Will only work on a Samsung P35 and probably crash any other machine
- Needs cleanup and a few conditional clauses to not trigger on any 
machine except Samsung P30/P35
- Needs to get a DMI string or other unique machine identification to 
trigger only on Samsung P30/P35
- Has only been tested on one machine

I'm sending this mail to gauge interest in my patch and I'll be sending 
it to interested parties privately on request. The patch will probably 
be published on my web site after I have confirmation from other users 
that it works for them.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
