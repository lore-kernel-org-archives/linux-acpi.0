From: Herman Sheremetyev <herman-6MNMYbGzEYJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATHC] Relaxed syntax for the processor PBLK length
Date: Mon, 31 Jan 2005 10:47:11 -0500
Message-ID: <41FE52FF.9080604@swebpage.com>
References: <41FD3E02.8010701@tremplin-utc.net> <20050131145836.GA1145@poupinou.org> <41FE4ABF.9040100@tremplin-utc.net> <20050131152931.GC1145@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050131152931.GC1145-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Eric Piel <Eric.Piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>, Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

A length other than 6 used to disable PBLK may also indicate that C 
states are implemented using _CST methods instead of the Processor 
structure.  At least that's how it is on Asus M6N series, PBLK length is 
set to 7, and there are some other clues in the FADT latency settings to 
indicate that the BIOS writers didn't want this info used.

-Herman

Bruno Ducrot wrote:
> On Mon, Jan 31, 2005 at 04:11:59PM +0100, Eric Piel wrote:
> 
>>Why? Actually this patch is especially designed to allow C3 state to be 
>>used on my computer. This works for more than 6 months without any 
>>appearent problem, is there anything I'm not aware of?
> 
> 
> I thought some BIOS devellopers wanted to use a size for the
> pblk of 5 just to not allow C3 (which correspond to the sixth io
> register).
> 
> I'm not alone to think this.
> 
> Nate: FreeBSD allow only C2 in this case.  What do you think about this
> report?
> Do you have an example of some kind of malfunction when enabling C3?
> 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
