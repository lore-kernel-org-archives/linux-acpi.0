From: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Subject: ACPI errors on Asus M6R with > 2.6.9
Date: Thu, 3 Feb 2005 12:22:57 +0100
Message-ID: <20050203112257.GL30343@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

[ the following is more-or-less filled into the Kernel bugzilla at
  http://bugme.osdl.org/show_bug.cgi?id=4150 - I just want to add
  some questions to ACPI gurus here :-]

	Hi all,

I have an Asus M6R laptop (http://www.fi.muni.cz/~kas/m6r/) - ACPI
seems to work with 2.6.8.1 and 2.6.9 but with anything newer I am
getting ACPI errors on boot and most ACPI-related features do not work
(battery status, ASUS modem LED, etc.).

The first error is the following:
ACPI-1138: *** Error: Method execution failed [\MCTH] (Node ddf006e0),
AE_AML_BUFFER_LIMIT

The \MCTH method seems to be a clumsy variant of strcmp() - I have
managed to fix it by adding the lines marked with "+". Is my fix correct
or is post-2.6.9 ACPI interpreter wrong?

    Method (MCTH, 2, NotSerialized)
    {
        If (LLess (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (Zero)
        }
+       If (LLess (SizeOf (Arg1), SizeOf (Arg0)))
+       {
+           Return (Zero)
+       }
        Add (SizeOf (Arg0), 0x01, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LNot (LEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (BUF1, Local0)))))
            {
                Return (Zero)
            }
        }
        Return (One)
    }

The above method is called by the following code:

        Store (0x01, OSVR)
        If (MCTH (\_OS, "Microsoft Windows NT"))
        {
            Store (0x00, OSVR)
        }

        Return (OSVR)

The second problem is the following error (which repeats itself after
almost any ACPI operation):

    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME

Again, 2.6.9 works, anything newer does not. I do not know how to solve
this problem. Any ideas?

My source and binary DSDT files are attached to the bugzilla entry
mentioned above.

Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
