From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: Why is the new patch against 2.4.20-pre3 and not 2.4.1 9?
Date: Tue, 20 Aug 2002 18:58:13 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020821105814.KBGEC0A82650.6C9EC293@mvf.biglobe.ne.jp>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DDB1@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DDB1-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Tue, 20 Aug 2002 10:42:42 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: VALETTE Eric [mailto:valette-9L3uxOwa2HHHNWWW6QW1Ag@public.gmane.org] 
> > I've tried to apply it on 2.4.19, it fails. I've tried on 
> > 2.4.20-pre4 it 
> > also fails :-(. So I have to stick with 2.4.20-pre3 which is known to 
> > cause some hangup on boot (see Marcello comment for pre4).
> 
> OK there's a patch against pre4 on sf.net now.

Andy, It seems that the patch on sf.net for 2.4.20-pre4 is almost
same as 20020726 release, few files are changed.
It seems to me that you merged wrong tree into your 2.4.20-pre4
and genereted the patch.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
