From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Broken Dell BIOSes (was: Re: ACPI question)
Date: Fri, 18 Nov 2005 16:27:09 +0000
Message-ID: <20051118162709.GA10204@srcf.ucam.org>
References: <1acba2fa0511180455s26c7192dyde34bec2565d8735@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1acba2fa0511180455s26c7192dyde34bec2565d8735-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mahmood NT <mahmood.nt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Nov 18, 2005 at 04:25:42PM +0330, Mahmood NT wrote:

> I have a DELL inspiron 510m running Fedora core 3 (2.6.9).
> I have trouble with my ACPI. When ever I close the lid, the screen goes off (I
> do not know whether it suspen to RAM or not).
> But when I open the lid, it does not wake up and the screen still is off. I
> must press the power button. therefore system shuts down
> and I must restart it again.

There's a bug in Dell's current laptop BIOSes. If you shut the lid and 
open them again, they won't switch the screen back on. I've been 
spending the past month fighting with Dell technical support over this, 
so if anyone has any contacts inside Dell, that would be great. The same 
thing happens if you boot Windows in safe mode, so it's certainly not a 
Linux bug.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
