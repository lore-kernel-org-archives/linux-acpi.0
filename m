From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Re: [RFC] Reliable video POSTing on resume (was: Re:
	[ACPI] Samsung P35, S3, black screen (radeon))
Date: Mon, 07 Feb 2005 14:25:12 +0000
Message-ID: <1107786312.8575.75.camel@tyrosine>
References: <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <1107485504.5727.35.camel@desktop.cunninghams>
	 <9e4733910502032318460f2c0c@mail.gmail.com>
	 <20050204074454.GB1086@elf.ucw.cz>
	 <9e473391050204093837bc50d3@mail.gmail.com>
	 <20050205093550.GC1158@elf.ucw.cz>
	 <1107695583.14847.167.camel@localhost.localdomain>
	 <1107782696.8575.72.camel@tyrosine>  <20050207140937.GA8040@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050207140937.GA8040-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Mon, 2005-02-07 at 15:09 +0100, Pavel Machek wrote:

> Where do I find code to do VBE save state? I might get you some
> testing...

http://www.srcf.ucam.org/~mjg59/vbetool/ - vbetool vbestate save will
dump the state to stdout, vbetool vbestate restore will restore whatever
is passed to it from stdin.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
