From: ahaning-mn4gwa5WIIQysxA8WJXlww@public.gmane.org
Subject: Pushing ACPI to 2.4.20?
Date: Tue, 24 Sep 2002 22:16:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3D90E44B.2030400@mindspring.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Perhaps I'm misunderstanding something or I just do not know what I'm 
doing WRT ACPI on my machine. I don't understand why there would be any 
push to get ACPI in the mainstream kernel when it seems that the major 
goal for now is just booting and assigning IRQs.

The machine that I'm using to test ACPI is a desktop, so maybe there's 
less concern for it for right now. However, I can't get any of the low 
power modes (except mode S5) to work. My machine either does nothing and 
continues to work normally, or it continues at full power until I 
momentarily press the power button, then my shell is returned to me.

Shouldn't I be able to at least suspend my machine to RAM and turn off 
all of the fans and disk, before this goes to the main kernel? Even with 
APM, I can put the machine in standby/suspend, I just don't get fan 
control, which is what I'd like.

Do I just not know what I'm doing? Should I be able to suspend my 
machine to RAM or disk with ACPI?

Thanks

Andy
haninger.3-ZbGKxL/pcrQ@public.gmane.org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
