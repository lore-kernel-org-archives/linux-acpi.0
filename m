From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]
 Samsung P35, S3, black screen (radeon))
Date: Sun, 06 Feb 2005 16:02:34 +0000
Message-ID: <1107695583.14847.167.camel@localhost.localdomain>
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050205093550.GC1158-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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
Cc: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sad, 2005-02-05 at 09:35, Pavel Machek wrote:
> Rumors say that notebooks no longer have video bios at C000h:0; rumors
> say that video BIOS on notebooks is simply integrated into main system
> BIOS. I personaly do not know if rumors are true, but PCs are ugly
> machines....
> 							

A small number of laptop systems are known to pull this trick. There are
other problems too - the video bios boot may make other assumptions
about access to PCI space, configuration, interrupts, timers etc.

Some systems (intel notably) appear to expect you to use the bios
save/restore video state not re-POST.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
