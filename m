From: "Christopher N. Deckard" <cnd@ecn.purdue.edu>
Subject: Re: cpu temp probs?
Date: Mon, 17 May 2004 19:41:06 -0500
Sender: swsusp-devel-admin@lists.sourceforge.net
Message-ID: <40A95BA2.5050008@ecn.purdue.edu>
References: <40A8D431.9090506@ecn.purdue.edu> <1084824054.23442.6.camel@localhost> <40A9272D.7040405@ecn.purdue.edu> <20040517211849.GB24480@hell.org.pl> <40A937F4.8090601@ecn.purdue.edu> <20040518000603.GA28576@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <swsusp-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040518000603.GA28576@hell.org.pl>
Errors-To: swsusp-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:swsusp-devel@lists.sourceforge.net>
List-Help: <mailto:swsusp-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Jon Olson <morph@damogran.org>, Software Suspend Mailing List <swsusp-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Karol Kozimor wrote:
> Thus wrote Christopher N. Deckard:
> 
>>>>I don't close the screen while suspending.  I have been waiting for 
>>>>a complete power off just to make sure it's doing it's thing...
>>>
>>>What does /proc/acpi/processor/*/* say before and after suspend (cat it
>>>several times at least)?
>>
>>After a normal boot, I seem to stay mostly in C2, but every now and 
>>then I see it jump to C1.  Jumps back to C2 almost immediately. 
>>After a suspend and resume I stay in C1.
> 
> That's odd. Are you sure it's not due to a run-away process or kernel
> thread such as keventd? If it's not, could you try reloading the processor
> module, or possibly unloading it before suspend and loading back after?
> Best regards,
> 

In /etc/suspend.conf I have this:

SWSUSP_REMOVEMODS="thermal fan button processor ac battery nvidia"

When acpid is started on resume, it reloads those modules.  You can 
see output from dmesg after a resume here:

http://globalfoo.net/Linux/Laptop/DellD800/20040512_suspend_resume.log

This is kernel 2.6.6 + swsusp2 2.0.0.72.  I don't see any runaway 
processes or kernel threads, or at least top isn't seeing any.

-Chris


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
