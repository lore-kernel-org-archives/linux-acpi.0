From: Mattia Dongili <malattia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: utmisc-0131: *** Error: Invalid owner_id: 00
Date: Thu, 18 Aug 2005 21:09:59 +0200
Message-ID: <20050818190959.GC6032@inferi.kami.home>
References: <20050818182153.GA6032@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050818182153.GA6032-MEqNC12sBsHxa7XIdbXXog@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Devel Maling List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 18, 2005 at 08:21:53PM +0200, Mattia Dongili wrote:
> Hello,
> 
> I'm seeing the error (almost randomly and at with a varying frequence)
> utmisc-0131: *** Error: Invalid owner_id: 00
> 
> It seems completely harmless but after some hours of work however this
> other related warning appears when reading the battery state:
> psparse-0509: *** Error: Method execution failed [\_SB_.PCI0.LPC0.EC
> 0_.ACAD._PSR] (Node c126e7c8), AE_OWNER_ID_LIMIT

Ooops, sorry didn't notice that the ac_adapter had the same issue when
reading its state (the log above refers to it)... Following the battery
state log (identical and I suppose it's already clear what's happening)

psparse-0509: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.EC0_.BAT1._BST] (Node c126eb08), AE_OWNER_ID_LIMIT

-- 
mattia
:wq!


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
