From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: D600 resume from RAM with black screen, ethernet tg3 is buggy
Date: Sat, 20 Sep 2003 18:58:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F6C8721.5050604@vsb.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

   Here is some of my result with D600:

   2.4.22 + swsuspend
     suspend to disk seems to work with small problems, but not tested 
hardly and is not much faster then reboot.

   2.6.0-test5 + test5-pm2.diff - kernel without modules, static

      - suspend "standby" do not switch off lcd. Is it ok?

      -suspend to ram work, but after resume is display black. Without 
test5-pm2 do not resume back and hang with black screen.

      -suspend to disk hang after hdc and hda suspended (hda is used for 
resume, why is suspended?). result:

....
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50:, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.

... and hang

I unable to use tg3 ethernet driver, because kernel fail somewhere in 
tg3  driver everytime I try suspend (backtrace list is too long on 
screen and I unable to scroll back).

Where are problems? How can I help to solve them?

thanks
   poli

p.s.





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
