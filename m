From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Re: S3 suspend and serial console
Date: Mon, 07 Feb 2005 18:14:57 +0100
Message-ID: <4207A211.3000305@gmx.net>
References: <42023083.8030508@gmx.net> <4204CA50.8090906@gmx.net> <20050205155845.GA20131@hell.org.pl> <20050205220619.GA30739@message-id.gmane0305.slipkontur.de> <4206CF63.2090600@gmx.net> <20050207141655.GB8040@elf.ucw.cz> <42077B07.5090606@gmx.net> <20050207143242.GE8040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050207143242.GE8040-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

Pavel Machek schrieb:
> Hi!
> 
> 
>>>>Erm... is it intentional that serial powermanagement code is never
>>>>called on entering/leaving S3? When I added debugging statements
>>
>>>Probably noone was yet trying to use serial during suspend....
>>
>>You mean noone uses the serial console while testing suspend?
>>What is the new way to debug suspend problems not requiring a
>>serial console?
> 
> Well, when video works, you debug using video. I used hardware
> debugger, too...

Will there be any patch to actually use the powermanagement code
in the serial core?


Regarding the original problem:
It seems the following call is sufficient to make the console work
again. However, I haven't found a function which would give me
the parameters needed to call ->set_termios.

serial/8250.c: serial8250_set_termios

Do you have any idea how to obtain the termios and tty structures
for a given port, e.g. ttyS0?

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
