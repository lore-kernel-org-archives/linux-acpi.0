From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: S3 suspend and serial console
Date: Mon, 07 Feb 2005 03:16:03 +0100
Message-ID: <4206CF63.2090600@gmx.net>
References: <42023083.8030508@gmx.net> <4204CA50.8090906@gmx.net> <20050205155845.GA20131@hell.org.pl> <20050205220619.GA30739@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050205220619.GA30739-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Stefan Seyfried schrieb:
> 
> only "> /dev/ttyS0", no echo. This basically does...
> 
> open("/dev/tty", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> fcntl64(1, F_GETFD)                     = 0
> fcntl64(1, F_DUPFD, 10)                 = 10
> fcntl64(1, F_GETFD)                     = 0
> fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
> dup2(3, 1)                              = 1
> close(3)                                = 0
> 
> so it is pretty equivalent to "echo -n > /dev/ttyS0"

Erm... is it intentional that serial powermanagement code is never
called on entering/leaving S3? When I added debugging statements
to the serial code, this seemed very strange.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
