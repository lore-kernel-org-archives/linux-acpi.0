From: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Subject: Re: best acpi solution
Date: Thu, 22 May 2003 14:13:50 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ECCDB1E.1060503@ottaky.com>
References: <3ECB3CE2.5000400@ottaky.com> <01db01c31f90$84ae6840$3746028e@bio.dfo.ca> <3ECB8ADF.5020108@ottaky.com> <20030521142117.GX346@poupinou.org> <3ECB9BB8.9070700@ottaky.com> <20030521150233.GY346@poupinou.org> <3ECBA777.9090100@ottaky.com> <20030521154428.GZ346@poupinou.org> <3ECBB096.3070207@ottaky.com> <3ECCD8CC.80704@ottaky.com> <20030522131345.GC11379@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030522131345.GC11379-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, May 22, 2003 at 02:03:56PM +0000, sjb wrote:
> 
>>My gcc version is
>>
>>linux:/usr/src/linux # gcc -v
>>gcc version 3.3 20030226 (prerelease) (SuSE Linux)
> 
> 
> This is your real problem.  Try compiling with 2.95 if you can.
> Otherwise you could just leave out that driver -- I'm sure you don't
> have an ambassador ATM card.
> 

I just created a new config without ATM - after a quick google search i 
realised it was of no use to me anyway ;-)

Cheers,

sjb



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
