From: "Adachi, Kenichi" <aileenja_jpn-xFOqZoH7zVZ4Eiagz67IpQ@public.gmane.org>
Subject: RE: Fan control for my Dell SmartPC
Date: Mon, 26 May 2003 23:20:01 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <001201c32391$ecc1cda0$354425db@sayonara>
References: <3ED1FC8B.2040009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ED1FC8B.2040009-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: 'roychris' <roychris-GANU6spQydw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi, 

> There isn't any method to control the Fan in the dsdt ACPI 
> table on my 
> computer (DELL SmartPC/SmartStep).
> Thanks to the ACPI Specs, I have implemented this code and 
> there is no 
> problem with the compilation. ACPI Linux driver indicates me that it 
> finds a method for my two logical fans (one fan with 2 speeds). But I 
> think that the adress (the namespace maybe EC0) is not good 
> so I can't 
> control it. How can I find the good region for my fan ?

Can you be more specific here:

- What was the original status/problem? (There was nothing w.r.t. Fan
control at all in your original DSDT, but your machine has been kept
chilled by Fan, correct?)
- What steps did you go through? (Trying to control Fan via ACPI by
adding your own methods without knowledge as to how your Embedded
Controller interacts with Fan controller etc.?)

The entire DSDT, both original and modified, will be required for
further investigation, but honestly speaking, there's little, if any,
hope of success...

Thanks,
- Adachi, Kenichi 





-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
