From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Masquerading operating systems (with ACPI_OS_NAME) does
	cause grief.
Date: Sun, 09 Jan 2005 14:22:18 +0000
Message-ID: <1105280538.14892.3.camel@tyrosine>
References: <1105278053.23887.35.camel@dangun.glencairn.bogus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1105278053.23887.35.camel-jrz8SJKx3bjmte52KpgHD8SwM44v/HSX@public.gmane.org>
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

On Sun, 2005-01-09 at 23:40 +1000, Barry Kitson wrote:

> Please note that (modulo VGA, which has it's own special set of
> problems) the only string (prefix) that causes suspend/resume of linux
> 2.6.10 to fail on a VIA EPIA CL10000 Mini-ITX motherboard (with either
> of the two available BIOS versions - 1.16 or 1.23) is the newish (but
> not entirely accurate) default of ACPI_OS_NAME="Microsoft Windows NT".
> When Linux declares itself to be NT, resumes just don't happen.  The fan
> and power supply wake up, but that's about all.  

It'd be good to see the DSDT, so we can try to work out why it makes a
difference.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
