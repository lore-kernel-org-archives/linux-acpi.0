From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Crash with fs corruption on 2.4.23-rc1 + CONFIG_ACPI_PROCESSOR
Date: Fri, 14 Nov 2003 13:47:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031114124713.GK32464@poupinou.org>
References: <20031113161857.GM26911@roosevelt.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031113161857.GM26911-sxQ6dllMCJFOpCWnugOeNx8pCrqmY5it@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stelian Pop <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 13, 2003 at 05:18:57PM +0100, Stelian Pop wrote:
> Hi,
> 
> Something is going very strange on my Transmeta powered Vaio C1VE laptop.
> This is with a RedHat Fedora core 1 installation, kernel compiled 
> with gcc 3.2.3.
> 
> If I compile a recent kernel (tried 2.4.23-rc1, and plain stock 2.4.22)
> with CONFIG_ACPI_PROCESSOR enabled, I get a bunch of oopses in the
> next 10-30 seconds.
> 
> When compiled statically into the kernel, the init scripts are 
> succesfuly ran, I can log in then I get an oops in the next 10 to 
> 30 seconds. Most often the oops is a BUG at page_alloc.c:188,
> but not always.
> 
> When compiled as a module, all goes well if the module is not loaded,
> and the crash happens moments after the loading of processor.o
> 
> After the oops, the / filesystem (ext3) gets corrupted and a manual
> fsck is required to solve some block duplication errors.
> 
> A 2.6.0-test9 compiled with CONFIG_ACPI_PROCESSOR on does not seem
> to have this problem.
> 
> Attached you'll find the .config and dmesg in case it is useful...
> 

Have you a decoded oops?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
