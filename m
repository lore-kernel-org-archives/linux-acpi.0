From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] Don't disable interrupts during EC access
Date: Tue, 16 Nov 2004 13:29:46 +0100
Message-ID: <20041116122946.GG28839@wotan.suse.de>
References: <3ACA40606221794F80A5670F0AF15F84041AC076@pdsmsx403> <20041116121616.GG1108@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041116121616.GG1108-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[I didn't see Luming's original mail, so answering to this one]

On Tue, Nov 16, 2004 at 12:16:16PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 16, 2004 at 02:15:47PM +0800, Yu, Luming wrote:
> > Andi,
> > 
> > This patch seems to break the atomic operation.
> > The original code enclosed by spin_lock_irqsave/spin_unlock_irqresotre is trying to make sure the first operation to EC_COMMAND
> > register , and the second operation to EC_DATA register belong to one atomic transaction.
> 
> Why would converting from a spinlock to a semaphore break this?

As Willy said the operation should be still atomic in respect to
the register.

And the event polling can take several ms, there is just no way 
to do this during runtime with interrupts off. Especially since
thermal will do this every few seconds. With my patch at least 
only kacpid is blocked for that long, not the whole system.

-Andi


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
