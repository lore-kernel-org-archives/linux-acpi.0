From: Mark Santcroos <marks-h3GR0owD+wQ@public.gmane.org>
Subject: Re: Fan control for my Dell SmartPC
Date: Mon, 26 May 2003 16:17:23 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030526141723.GI658@laptop.6bone.nl>
References: <3ED1FC8B.2040009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ED1FC8B.2040009-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: roychris <roychris-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

But is your fan ACPI controllable?

Mark

On Mon, May 26, 2003 at 01:37:47PM +0200, roychris wrote:
> There isn't any method to control the Fan in the dsdt ACPI table on my 
> computer (DELL SmartPC/SmartStep).
> Thanks to the ACPI Specs, I have implemented this code and there is no 
> problem with the compilation. ACPI Linux driver indicates me that it 
> finds a method for my two logical fans (one fan with 2 speeds). But I 
> think that the adress (the namespace maybe EC0) is not good so I can't 
> control it. How can I find the good region for my fan ?
> 
>            OperationRegion (EC0, EmbeddedControl, 0, 0xFF)
>            Field (EC0, ByteAcc, Lock, Preserve)
>            {
>             MODE,     1,
>             FAN0,     1,
>             FAN1,     1,
>             ,         5,
>             TMP,      8,
>             AC0,      8,
>             AC1,      8,
>             PSV,      8,
>             HOT,      8,
>             CRT,      8
>             }
> 
> I think that it's this piece of code I have to change.
> 
> Thanks
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ObjectStore.
> If flattening out C++ or Java code to make your application fit in a
> relational database is painful, don't do it! Check out ObjectStore.
> Now part of Progress Software. http://www.objectstore.net/sourceforge
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Mark Santcroos                    RIPE Network Coordination Centre
http://www.ripe.net/home/mark/    New Projects Group/TTM


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
