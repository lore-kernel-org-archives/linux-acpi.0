From: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Re: swsusp and ac status
Date: Mon, 28 Jun 2004 22:29:36 +0200
Sender: swsusp-devel-admin@lists.sourceforge.net
Message-ID: <20040628202936.GJ698@openzaurus.ucw.cz>
References: <200406250701.i5P71GKC006204@fermat.unipv.it> <opr95d71ln4evsfm@smtp.pacific.net.th> <20040627222842.GB1816@hell.org.pl> <opr992vyyr4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <swsusp-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <opr992vyyr4evsfm@smtp.pacific.net.th>
Errors-To: swsusp-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:swsusp-devel@lists.sourceforge.net>
List-Help: <mailto:swsusp-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/swsusp-devel>,
	<mailto:swsusp-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=swsusp-devel>
To: Michael Frank <mhf@linuxmail.org>
Cc: Karol Kozimor <sziwan@hell.org.pl>, Daniele Boffi <boffi@dimat.unipv.it>, acpi-devel@lists.sourceforge.net, Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >As far as I know, there is no need to reinitialize the AC module, as 
> >it
> >does not cache the results -- upon read, it calls the appropriate 
> >_PSR
> >method which is supposed to return the correct AC adapter state, as 
> >simple
> >as it gets. This way, any problems would indicate a faulty BIOS.
> >Best regards,
> >
> 
> Sorry, the BIOS does not know about suspend.

Hacky solution is to call _WAK so that BIOS updates is caches...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
