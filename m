From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: S3 suspend and serial console
Date: Sat, 5 Feb 2005 23:06:19 +0100
Message-ID: <20050205220619.GA30739@message-id.gmane0305.slipkontur.de>
References: <42023083.8030508@gmx.net> <4204CA50.8090906@gmx.net> <20050205155845.GA20131@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205155845.GA20131-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 05, 2005 at 04:58:45PM +0100, Karol Kozimor wrote:
 
> echo > /dev/ttyS0 will echo a single '\n'. I guess echo -n would be more

only "> /dev/ttyS0", no echo. This basically does...

open("/dev/tty", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
fcntl64(1, F_GETFD)                     = 0
fcntl64(1, F_DUPFD, 10)                 = 10
fcntl64(1, F_GETFD)                     = 0
fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
dup2(3, 1)                              = 1
close(3)                                = 0

so it is pretty equivalent to "echo -n > /dev/ttyS0"
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
