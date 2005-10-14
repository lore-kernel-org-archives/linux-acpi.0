From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI event problems...
Date: Fri, 14 Oct 2005 10:50:21 +0800
Message-ID: <200510141050.22032.luming.yu@intel.com>
References: <loom.20051013T185813-5@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20051013T185813-5-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Content-Disposition: inline
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

On Friday 14 October 2005 01:05, GregR wrote:
> I have a laptop (Sharp PCAV18) that has some terrible problems with ACPI.
> Right now I am not trying to get sleep or suspend/hibernate working as the
> biggest problem I have is lockups.
>
> For any ACPI event related to the LID ac_adapter or battery that happens,
> the thing freezes.  If I plug/unplug the ac_adapter it freezes.  If I
> insert the battery when on ac power it freezes.  When the battery goes from
> charging to full it freezes.  When the LID button is triggered, it freezes.
>
> I have tried the latest kernel (1.6.13.4), compiled with the ACPI features
> built in, and as modules.  I have compiled my own DSDT and installed that
> in the kernel.  Nothing seems to make any difference.
>
> If I boot using a Knoppix CD, it all seems to work great.  The distro I am
> using is Mandriva, I have tried both 2005 and 2006.  Same thing.
>
> If there is any information that I can post, I would be more than willing
> to do so.  Just let me know what you need.
>
> Thanks
>
> Greg
>
>
Please open a bug at bugzilla.kernel.org

Thanks,
Luming


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
