From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: AML disassembler questions.
Date: Fri, 9 Aug 2002 12:10:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020809101053.GB24541@poup.poupinou.org>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6D0@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B6D0-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Ducrot Bruno' <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Black, Richard" <Richard.Black-VXdhtT5mjnY@public.gmane.org>, "KOCHI, Takayoshi" <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Aug 08, 2002 at 12:50:25PM -0700, Moore, Robert wrote:
> 
> Go ahead and try the disassembler in iASL.  I know for a fact that it
> disassembles lots of files that AD chokes on.
> 

I try it for a Sony AML (don't remember the model, though).

ad.exe gave me:

	...
	...
        Method(S2BF,1,Serialized)
        {
            Add(SLEN /* **** can't find object in namespace */(),Arg0,)
AML error: Invalid Term in TermList @ 403406BC
           Probably a disassembler problem
                  Opcode = 0x01,0x60
        }
AML error: Invalid Term in TermList @ 403406BC
           Probably a disassembler problem
                  Opcode = 0x01,0x60
    }
AML error: Invalid Term in TermList @ 403406BC
           Probably a disassembler problem
                  Opcode = 0x01,0x60
}


acpidump is ok, under Linux and F-BSD (I received this AML some time ago).

I have try 'iasl -d' for this AML, and it was OK.

I have some other AMLs in hand that can not be disassembled by ad.exe,
and iasl seems to be OK for me.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
