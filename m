From: "Martin J. Bligh" <Martin.Bligh-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Discontig-devel] Cleanup of NUMA support in ACPI
Date: Wed, 07 Aug 2002 11:11:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3980000.1028743885@flay>
References: <20020807033450.DALTC0A82650.6C9EC293@mvf.biglobe.ne.jp> <200208072001.50565.efocht@ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200208072001.50565.efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Erich Focht <efocht-+HQ0pkNQ8fyELgA04lAiVw@public.gmane.org>, "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Cc: discontig-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Tuesday 06 August 2002 20:36, KOCHI, Takayoshi wrote:
>> tristated.  The division is because I'd like to distinguish
>> ACPI-dependent NUMA initialization stuff and
>> others (like SGI or phoney_srat/slit).
> 
> SGI definitely uses SLIT/SRAT, too.

The IBM x440 (ia32 NUMA) uses SRAT too, I believe.
We will send out patches soon.

M.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
