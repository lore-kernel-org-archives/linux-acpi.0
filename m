From: Ron Rechenmacher <ron-vjLZTnyA75mSFZzDrWHoTA@public.gmane.org>
Subject: HELP with 82855PM chipset issue
Date: Tue, 28 Dec 2004 21:08:42 -0600
Message-ID: <200412290308.iBT38gw2025166@fnapcf.fnal.gov>
Reply-To: ron-13hema8v3vg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: ron-13hema8v3vg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I hope this is considered only a bit off track (sorry)...
I have a Dell Precision M60 and under linux or windows I see significant (~17%)
decrease in main memory performance after the 1st software suspend to ram or 
standby. I would appreciated if any one that has an 82855PM system from 
another vendor could:
     
     1a. verify that the chipset is 82855PM and note the rev (03 or 21)
     1b. boot or reboot
     2a. if linux, record the output of "lspci -xxx" (lspci -xxx >before.txt)
     2b. measure main memory bandwidth (prior to the 1st suspend after reboot)
     3.  software suspend (or standby under windows)
     4.  wake (via power button)
     5a. remeausure main memory bandwith and (potentially) notice decrease
         in performance. Note that L1/L2 cache performance does not decrease.
     5b. if linux, record the output of "lspci -xxx" (lspci -xxx >after.txt)

and reply to me the results.
Further info (including bandwidth measurement software info) can be found at:
     http://bugzilla.kernel.org/show_bug.cgi?id=3918

Thanks for your help,
Ron




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
