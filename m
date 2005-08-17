From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: EC Confusion
Date: Wed, 17 Aug 2005 13:37:54 +0200
Message-ID: <43032192.7050307@suse.de>
References: <BAY12-F48160AB3D3ABB69E3A006A8BA0@phx.gbl> <42F9A4D8.1090703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42F9A4D8.1090703-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thomas Renninger wrote:
> Paulo Vitor Magacho da Silva wrote:
> 
>>Hi,
>>
>>I hit seven times the sleep button and I get the same message :
>>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d52e8)
>>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d5168)
>>Then, in the 8th time I get:
>>kernel:  Execute Method: [\_SB_.PCI0.LPC0.EC__._Q0D] (Node c14d5f28)
>>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.BAT0._BST] (Node c14d52e8)
>>kernel: Execute Method: [\_SB_.PCI0.LPC0.EC__.AC__._PSR] (Node c14d5168)
>>
> 
> Seems as if the ACPI events are buffered?
> I had a very similar bug report:
> ________________________________________
> The ACPI events, which are triggered by keyboard (via Fn key, eg. to switch
> WiFi card on/off) are somehow buffered in the kernel. I have to push the key
> combination 8 times until acpi_listen (or cat /proc/acpi/event) gets the first
> event, then, if I push other combinations, I get the events from the "buffer".
> ________________________________________
> 
> EC burst mode did solve this problem on that machine.
> 
Seems there is a regression in the EC burst mode code:
EC burst mode does not solve the problem for this guy in current kernels any more.

I used one of the patches applied to:
http://bugzilla.kernel.org/show_bug.cgi?id=3851
(Sorry don't know the exact one any more, was about a month or a bit more ago).
With that one the buffered key issue was gone.

He now retested with current kernels: 2.6.13-rc6-git1-2 and the problem exists again.

Maybe Paolo should raise a new bug for that issue if not already done?
Please CC me.

Thanks,

    Thomas


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
