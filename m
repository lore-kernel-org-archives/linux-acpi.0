From: Alexey Spiridonov <lesha-Gubx2rHcMmiHXe+LvDLADg@public.gmane.org>
Subject: kacpid 100% CPU when lid closed
Date: Mon,  9 Aug 2004 07:05:11 +0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040809030511.9842.qmail@mailgate.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

I have a Dell 2650. Whenever I close the lid, the GPE code starts handling massive amounts of L1D events, which yields the CPU usage.
This problem started with kernel 2.6.5. Right now, I'm running 2.6.8-pre3 with the latest ACPI patches. There have been several messages 
from end-users to LKML about this. Please refer to mine for some profiling results and traces:

http://lkml.org/lkml/2004/7/8/1

The first message from May, 2004 is here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0405.1/1285.html

It would be wonderful if a knowledgeable person could give some suggestions, or even fix it (I'm happy to help, just tell me how).
I'm quite tired of living in the stone age of 2.6.3 :)

Please Cc: lesha-Gubx2rHcMmjdyZFCUbrdog@public.gmane.org

Thanks a lot!

Alexey


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
