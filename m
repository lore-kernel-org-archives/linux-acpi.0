From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: iasl
Date: Fri, 9 May 2003 17:42:24 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030509154224.GK2954@poup.poupinou.org>
References: <3EBA7BE0.5070200@ottaky.com> <20030509133703.GH2954@poup.poupinou.org> <3EBBD495.7050104@ottaky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EBBD495.7050104-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sjb <ottaky-XuTx12Z7TonQT0dZR+AlfA@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, May 09, 2003 at 04:17:25PM +0000, sjb wrote:
> Ducrot Bruno wrote:
> 
> >grab acpica-unix from intel site instead, untar, go to 'compiler' 
> >directory,
> >'make' and hopefully you will get iasl.
> 
> D'oh! Why didn't I think of that?! *8-)
> 
> >I do have trouble with bison version 1.75, but I guess that my bison
> >is broken ? With bison 1.31, all seems to be OK.
> >Plus, I got some random core dump with the latest one? 
> 
> Well .. mine compiled cleanly and ..
> 
> ottaky@vaio:~/acpi> ./iasl -tc dsdt.asl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030424 [May  7 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> dsdt.asl   529:                 Field(ECR_, AnyAcc, Lock, Preserve) {
> Error    1048 -                          ^ Host Operation Region 
> requires ByteAcc access

It should be ByteAcc instead of AnyAcc

> dsdt.asl  1288:             Field(PIUC, DWordAcc, Lock, Preserve) {
> Error    1047 -                      ^ Access width is greater than 
> region size

Hard to tell.  Need the PIUC definition:

OperationRegion(PIUC, ..., ..., ...)

and all the Field(s) (with their content) which
look like 

Field(PIUC, ...) {
...
}


(but if PIUC is a OP defined as a PCI_Config, I would say that it should be
ByteAcc, or WordAcc.  I doubt that it have to be DWordAcc).

> 
> dsdt.asl  2122:             If(\_OSI) {
> Error    1028 -  Too few arguments ^  (\_OSI requires 1)
> 
> dsdt.asl  2123:                 "Windows 2001"
> Error    1037 -                  parse error ^

It should be

	If(\_OSI("Windows 2001")) {

and you may have to add:
extern (\_OSI)
(but I am not sure if it is OK with latest iasl).

BTW, could you try 'iasl -d mydsdt' in order to disassemble your DSDT, and
check if 'If (\_OSI ("Windows 2001"))' is correct ?

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
