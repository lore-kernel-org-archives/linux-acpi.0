From: ms-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Subject: dsdt-fix
Date: Fri,  7 Mar 2003 11:08:50 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1047031730.79060b58ba4bb@webmail.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi!

i'm owning a maxdata pro650T notebook with a broken acpi-dsdt. i could fix the 
two errors acording to the description of howto, but there remains still three 
warnings. while it doesn't work correct, i tried to eliminate these too, but i 
don't know, if i'm right. two of them are in the SIRA/FIRA device section; i 
tried to change the to returns in one. is this correct (it compiles without 
warning)?
            Device(SIRA) {
                Name(_HID, 0x1005d041)
                Method(_STA) {
                    Store(0x82, \_SB_.BCMD)
                    Store(0x0, \_SB_.SMIC)
                    If(INF1) {
                        If(Or(LEqual(INF_, 0x1), LEqual(INF_, 0x2), )) {
                            ENFG()
                            And(CR25, 0xc0, Local0)
                            And(CR02, 0x80, Local1)
                            EXFG()
                            If(LAnd(Local0, Local1)) {
                                Return(0xf)
                            }
                            Else {
				Return(Package(0x02){0x05, 0x0d})
/*  --- changed after warning:
    --- dslt.asl  1260:                                 Return(0xd)
    --- Warning  2079 -                 Statement is unreachable ^ 

                                Return(0x5)
                                Return(0xd)
/
                           }
                       }
                       Else {
                           Return(0x0)
                       }
                   }
                   Else {
                       Return(0x0)
                   }
               }


the other (device LPT) is also in the _STA method, but a bit different. i dont 
know, what i should do here; i uncommended the second line and then is also no 
warning anymore, but what is the right way (without loosing this data)?

            Device(LPT_) {
                Method(_HID) {
                    ENFG()
                    NAnd(CR01, 0x8, Local0)
                    And(CR04, 0x2, Local1)
                    EXFG()
                    If(LAnd(Local0, Local1)) {
                        Return(0x0104d041)
                    }
                    Else {
                        Return(0x0004d041)
                    }
                }
                Method(_STA) {
                    Store(0x84, \_SB_.BCMD)
                    Store(0x0, \_SB_.SMIC)
                    If(INF_) {
                        ENFG()
                        And(CR23, 0xc0, Local0)
                        And(CR01, 0x4, Local1)
                        EXFG()
                        If(LAnd(Local0, Local1)) {
                            Return(0xf)
                        }
                        Else {
                            Return(0x5)
/*  --- removed after warning:
    --- dslt.asl   957:                             Store(0xd, Local7)
    --- Warning  2079 -            Statement is unreachable ^ 

                            Store(0xd, Local7)
*/
                        }
                    }
                    Else {
                        Return(0x0)
                    }
                }



thanx&bye masc

--
...martin schneebacher...      http://www.sbox.tu-graz.ac.at/home/m/ms/
                               mailto:ms-pBHEijV+WBpYQAAANFurAbNldLUNz+W/@public.gmane.org



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
