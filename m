From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Patch for ospmd thermal gui
Date: Mon, 31 Mar 2003 19:00:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1049130005.351.17.camel@bacchus.gpphy.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_NS8L3YY3TBOgDvLOHWH18Q)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_NS8L3YY3TBOgDvLOHWH18Q)
Content-type: text/plain
Content-transfer-encoding: QUOTED-PRINTABLE

Hello Andrew,

as you suggested last year I made the ospmd_gui have a thermal page. =
Now
I found the time to clean the patch up and send it to you.

While working on the clean-up, it struck me that I took a wrong
direction in comparison to what you have in mind about libpower/ospmd=
:

I always thought to transparently export the acpi interface through
ospmd/libpower. That is why I made one struct (PM_THERMAL_DATA) per
zone. Now that seems plain wrong to me.

As I understand today you want ospmd to gather those information need=
ed
for power management (policies) from /proc/acpi and export control of
ospmd via libpower - is that right?

In conclusion that would rather mean to have access to eg cooling
mode/temperature (in ospmd _and_ libpower) via:

pm_set_thermal_cooling
pm_get_thermal_cooling
pm_get_thermal_temperature

to be able to either set cooling mode from the gui directly or have a
policy in ospmd that eg switches cooling mode to active when a certai=
n
temperature is reached.

Sorry for not simply doing it and sending a patch - but it seems to m=
e
that I rather create more work for you by doing it wrong than by tryi=
ng
to understand your picture of ospmd/libpower development first.

Regards
-Knut
--=20
Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>


--Boundary_(ID_NS8L3YY3TBOgDvLOHWH18Q)
Content-type: text/x-patch; charset=ISO-8859-15; name=thermalgui.patch
Content-disposition: attachment; filename=thermalgui.patch
Content-transfer-encoding: QUOTED-PRINTABLE

diff -Nur ospmd-20030327.autotools/gui/Makefile.am ospmd/gui/Makefile=
.am
--- ospmd-20030327.autotools/gui/Makefile.am=09Mon Mar 31 18:39:54 20=
03
+++ ospmd/gui/Makefile.am=09Mon Mar 31 15:05:28 2003
@@ -7,7 +7,8 @@
 =09moc_BatDetails.cpp=09=09\
 =09moc_CriticalAlarmDialog.cpp=09\
 =09moc_BatteryPage.cpp=09=09\
-=09moc_PowerPage.cpp
+=09moc_PowerPage.cpp=09=09\
+=09moc_ThermalPage.cpp
=20
 BUILT_SOURCES=09=09=3D=09=09\
 =09$(MOC_FILES)
@@ -40,6 +41,8 @@
 =09ButtonPage.cpp=09=09\
 =09LowAlarmDialog.h=09\
 =09ButtonPage.h=09=09\
+=09ThermalPage.h=09=09\
+=09ThermalPage.cpp=09=09\
 =09$(MOC_FILES)
=20
 ospmd_gui_LDADD =3D $(top_srcdir)/libpower/libpower.la -L/usr/X11R6/=
lib $(LIB_QT)
diff -Nur ospmd-20030327.autotools/gui/PropertySheet.cpp ospmd/gui/Pr=
opertySheet.cpp
--- ospmd-20030327.autotools/gui/PropertySheet.cpp=09Mon Mar 31 18:38=
:28 2003
+++ ospmd/gui/PropertySheet.cpp=09Mon Mar 31 15:08:16 2003
@@ -126,7 +126,7 @@
=20
 PropertySheet::PropertySheet( QWidget *parent, const char *name, boo=
l modal, WFlags f )
     : QTabDialog( parent, name, modal, f ), gi(parent,name), bp(pare=
nt,name),
-=09pBat(parent,name), pp(parent,name)
+      pBat(parent,name), pp(parent,name), tp(parent, name)
 {
 =09int err;
 =09pt =3D NULL;
@@ -176,6 +176,7 @@
=20
 =09addTab( &pp, "Power" );
=20
+=09addTab( &tp, "Thermal" );
=20
 =09// Note that the dialog can have as many as four buttons.
 =09// There is always an OK button.
diff -Nur ospmd-20030327.autotools/gui/PropertySheet.h ospmd/gui/Prop=
ertySheet.h
--- ospmd-20030327.autotools/gui/PropertySheet.h=09Mon Mar 31 18:38:2=
8 2003
+++ ospmd/gui/PropertySheet.h=09Mon Mar 31 15:10:32 2003
@@ -184,6 +184,7 @@
 #include "ButtonPage.h"
 #include "BatteryPage.h"
 #include "PowerPage.h"
+#include "ThermalPage.h"
=20
 /*Linux OSPM GUI main QTabDialog "property sheet" include*/
 #include "PropertySheetDefs.h"
@@ -206,7 +207,8 @@
 =09ButtonPage bp;
 =09Batteries pBat;
 =09PowerPage pp;
-
+=09ThermalPage tp;
+=09
 public slots:
 =09void CloseMe();
=20
diff -Nur ospmd-20030327.autotools/gui/ThermalPage.cpp ospmd/gui/Ther=
malPage.cpp
--- ospmd-20030327.autotools/gui/ThermalPage.cpp=09Thu Jan  1 01:00:0=
0 1970
+++ ospmd/gui/ThermalPage.cpp=09Mon Mar 31 17:06:19 2003
@@ -0,0 +1,207 @@
+/*
+  Filename: ThermalPage.cpp
+  Purpose:  To display information on the computers Thermal Zone(s)
+*/
+
+/*******************************************************************=
***********
+ *
+ * 1. Copyright Notice
+ *
+ * Some or all of this work - Copyright (c) 1999-2002, Intel Corp.
+ * All rights reserved.
+ *
+ * 2. License
+ *
+ * 2.1. This is your license from Intel Corp. under its intellectual=
 property
+ * rights.  You may have additional license terms from the party tha=
t provided
+ * you this software, covering your right to use that party's intell=
ectual
+ * property rights.
+ *
+ * 2.2. Intel grants, free of charge, to any person ("Licensee") obt=
aining a
+ * copy of the source code appearing in this file ("Covered Code") a=
n
+ * irrevocable, perpetual, worldwide license under Intel's copyright=
s in the
+ * base code distributed originally by Intel ("Original Intel Code")=
 to copy,
+ * make derivatives, distribute, use and display any portion of the =
Covered
+ * Code in any form, with the right to sublicense such rights; and
+ *
+ * 2.3. Intel grants Licensee a non-exclusive and non-transferable p=
atent
+ * license (with the right to sublicense), under only those claims o=
f Intel
+ * patents that are infringed by the Original Intel Code, to make, u=
se, sell,
+ * offer to sell, and import the Covered Code and derivative works t=
hereof
+ * solely to the minimum extent necessary to exercise the above copy=
right
+ * license, and in no event shall the patent license extend to any a=
dditions
+ * to or modifications of the Original Intel Code.  No other license=
 or right
+ * is granted directly or by implication, estoppel or otherwise;
+ *
+ * The above copyright and patent license is granted only if the fol=
lowing
+ * conditions are met:
+ *
+ * 3. Conditions
+ *
+ * 3.1. Redistribution of Source with Rights to Further Distribute S=
ource.
+ * Redistribution of source code of any substantial portion of the C=
overed
+ * Code or modification with rights to further distribute source mus=
t include
+ * the above Copyright Notice, the above License, this list of Condi=
tions,
+ * and the following Disclaimer and Export Compliance provision.  In=
 addition,
+ * Licensee must cause all Covered Code to which Licensee contribute=
s to
+ * contain a file documenting the changes Licensee made to create th=
at Covered
+ * Code and the date of any change.  Licensee must include in that f=
ile the
+ * documentation of any changes made by any predecessor Licensee.  L=
icensee
+ * must include a prominent statement that the modification is deriv=
ed,
+ * directly or indirectly, from Original Intel Code.
+ *
+ * 3.2. Redistribution of Source with no Rights to Further Distribut=
e Source.
+ * Redistribution of source code of any substantial portion of the C=
overed
+ * Code or modification without rights to further distribute source =
must
+ * include the following Disclaimer and Export Compliance provision =
in the
+ * documentation and/or other materials provided with distribution. =
 In
+ * addition, Licensee may not authorize further sublicense of source=
 of any
+ * portion of the Covered Code, and must include terms to the effect=
 that the
+ * license from Licensee to its licensee is limited to the intellect=
ual
+ * property embodied in the software Licensee provides to its licens=
ee, and
+ * not to intellectual property embodied in modifications its licens=
ee may
+ * make.
+ *
+ * 3.3. Redistribution of Executable. Redistribution in executable f=
orm of any
+ * substantial portion of the Covered Code or modification must repr=
oduce the
+ * above Copyright Notice, and the following Disclaimer and Export C=
ompliance
+ * provision in the documentation and/or other materials provided wi=
th the
+ * distribution.
+ *
+ * 3.4. Intel retains all right, title, and interest in and to the O=
riginal
+ * Intel Code.
+ *
+ * 3.5. Neither the name Intel nor any other trademark owned or cont=
rolled by
+ * Intel shall be used in advertising or otherwise to promote the sa=
le, use or
+ * other dealings in products derived from or relating to the Covere=
d Code
+ * without prior written authorization from Intel.
+ *
+ * 4. Disclaimer and Export Compliance
+ *
+ * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE P=
ROVIDED
+ * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL =
SOFTWARE
+ * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASS=
ISTANCE,
+ * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE=
 ANY
+ * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIM=
S ANY
+ * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNES=
S FOR A
+ * PARTICULAR PURPOSE.
+ *
+ * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS =
LICENSEES
+ * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS O=
F USE OR
+ * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY =
INDIRECT,
+ * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, U=
NDER ANY
+ * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETH=
ER INTEL
+ * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIM=
ITATIONS
+ * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE =
OF ANY
+ * LIMITED REMEDY.
+ *
+ * 4.3. Licensee shall not export, either directly or indirectly, an=
y of this
+ * software or system incorporating such software without first obta=
ining any
+ * required license or other approval from the U. S. Department of C=
ommerce or
+ * any other agency or department of the United States Government.  =
In the
+ * event Licensee exports any such software from the United States o=
r
+ * re-exports any such software from a foreign destination, Licensee=
 shall
+ * ensure that the distribution and export/re-export of the software=
 is in
+ * compliance with all laws, regulations, orders, or other restricti=
ons of the
+ * U.S. Export Administration Regulations. Licensee agrees that neit=
her it nor
+ * any of its subsidiaries will export/re-export any technical data,=
 process,
+ * software, or service, directly or indirectly, to any country for =
which the
+ * United States government or any agency thereof requires an export=
 license,
+ * other governmental approval, or letter of assurance, without firs=
t obtaining
+ * such license, approval or letter.
+ *
+ *******************************************************************=
**********/
+
+
+#include "ThermalPage.h"
+
+char* thermal_mode[]=3D{"<Not Supported>", "Active", "Passive"};
+char* thermal_state[]=3D{"Ok", "Critical"};
+
+ThermalPage::ThermalPage( QWidget *parent, const char *name): QWidge=
t(parent, name)
+{
+=09int count =3D 0;
+
+=09qfFont =3D new QFont ("Helvetica", 11, QFont::Bold);
+
+=09qlIntro =3D new QLabel(this);
+=09qlIntro->setFont(*qfFont);
+=09qlIntro->setGeometry(20,20,420,40);
+=09qlIntro->setFrameStyle( QFrame::Box | QFrame::Raised );
+=09qlIntro->setMargin(2);
+=09qlIntro->setAlignment( Qt::AlignTop | Qt::AlignLeft );
+=09qlIntro->setTextFormat( Qt::RichText );
+=09qlIntro->setIndent(2);
+=09qsIntro =3D new QString();
+
+=09if( qsIntro !=3D NULL )
+=09{
+=09=09qsIntro->sprintf("Select Thermal Zone from List to display inf=
ormation about it.\n");
+=09=09qlIntro->setText(*qsIntro);
+=09}
+
+=09qlZK =3D new QLabel (this);
+=09qlZK->setFont (*qfFont);
+=09qlZK->setGeometry (20,80,240,20);
+=09qsZK =3D new QString ();
+=09qsZK->sprintf("Thermal Zone");
+=09qlZK->setText(*qsZK);
+
+=09cbZoneKey =3D new QComboBox(FALSE, this);
+=09cbZoneKey->setFont(*qfFont);
+=09cbZoneKey->setGeometry(180, 80, 110, 20);
+
+=09pm_get_thermal_data (&data);
+
+=09/* [FIXME: Have a key item in PM_THERMAL_DATA] */
+=09
+=09cbZoneKey->insertItem ("THRM");
+
+=09qlCM =3D new QLabel(this);
+=09qlCM->setFont(*qfFont);
+=09qlCM->setGeometry(20,120,240,20);
+=09qsCM =3D new QString ();
+=09qsCM->sprintf("Cooling Mode: \t\t%s", thermal_mode[data.cooling_m=
ode]);
+=09qlCM->setText(*qsCM);
+
+=09qlPF =3D new QLabel(this);
+=09qlPF->setFont(*qfFont);
+=09qlPF->setGeometry(20,140,240,20);
+=09qsPF =3D new QString ();
+=09qsPF->sprintf("Polling Frequency: \t%i", data.polling_frequency);
+=09qlPF->setText(*qsPF);
+
+=09qlST =3D new QLabel(this);
+=09qlST->setFont(*qfFont);
+=09qlST->setGeometry(20,160,240,20);
+=09qsST =3D new QString ();
+=09qsST->sprintf("State: \t\t\t%s", thermal_state[data.state]);
+=09qlST->setText(*qsST);
+
+=09qlTP =3D new QLabel(this);
+=09qlTP->setFont(*qfFont);
+=09qlTP->setGeometry(20,180,240,20);
+=09qsTP =3D new QString ();
+=09qsTP->sprintf("Temperature: \t\t%i =B0C", data.temperature);
+=09qlTP->setText(*qsTP);
+}
+
+ThermalPage::~ThermalPage ()
+{
+ =09delete qsTP;
+=09delete qlTP;
+
+ =09delete qsST;
+=09delete qlST;
+
+ =09delete qsPF;
+=09delete qlPF;
+
+ =09delete qsCM;
+=09delete qlCM;
+
+=09delete qsIntro;
+=09delete qlIntro;
+
+=09delete qfFont;
+}
diff -Nur ospmd-20030327.autotools/gui/ThermalPage.h ospmd/gui/Therma=
lPage.h
--- ospmd-20030327.autotools/gui/ThermalPage.h=09Thu Jan  1 01:00:00 =
1970
+++ ospmd/gui/ThermalPage.h=09Mon Mar 31 17:03:09 2003
@@ -0,0 +1,188 @@
+
+// Filename: ThermalPage.h
+
+/*******************************************************************=
***********
+ *
+ * 1. Copyright Notice
+ *
+ * Some or all of this work - Copyright (c) 1999-2002, Intel Corp.
+ * All rights reserved.
+ *
+ * 2. License
+ *
+ * 2.1. This is your license from Intel Corp. under its intellectual=
 property
+ * rights.  You may have additional license terms from the party tha=
t provided
+ * you this software, covering your right to use that party's intell=
ectual
+ * property rights.
+ *
+ * 2.2. Intel grants, free of charge, to any person ("Licensee") obt=
aining a
+ * copy of the source code appearing in this file ("Covered Code") a=
n
+ * irrevocable, perpetual, worldwide license under Intel's copyright=
s in the
+ * base code distributed originally by Intel ("Original Intel Code")=
 to copy,
+ * make derivatives, distribute, use and display any portion of the =
Covered
+ * Code in any form, with the right to sublicense such rights; and
+ *
+ * 2.3. Intel grants Licensee a non-exclusive and non-transferable p=
atent
+ * license (with the right to sublicense), under only those claims o=
f Intel
+ * patents that are infringed by the Original Intel Code, to make, u=
se, sell,
+ * offer to sell, and import the Covered Code and derivative works t=
hereof
+ * solely to the minimum extent necessary to exercise the above copy=
right
+ * license, and in no event shall the patent license extend to any a=
dditions
+ * to or modifications of the Original Intel Code.  No other license=
 or right
+ * is granted directly or by implication, estoppel or otherwise;
+ *
+ * The above copyright and patent license is granted only if the fol=
lowing
+ * conditions are met:
+ *
+ * 3. Conditions
+ *
+ * 3.1. Redistribution of Source with Rights to Further Distribute S=
ource.
+ * Redistribution of source code of any substantial portion of the C=
overed
+ * Code or modification with rights to further distribute source mus=
t include
+ * the above Copyright Notice, the above License, this list of Condi=
tions,
+ * and the following Disclaimer and Export Compliance provision.  In=
 addition,
+ * Licensee must cause all Covered Code to which Licensee contribute=
s to
+ * contain a file documenting the changes Licensee made to create th=
at Covered
+ * Code and the date of any change.  Licensee must include in that f=
ile the
+ * documentation of any changes made by any predecessor Licensee.  L=
icensee
+ * must include a prominent statement that the modification is deriv=
ed,
+ * directly or indirectly, from Original Intel Code.
+ *
+ * 3.2. Redistribution of Source with no Rights to Further Distribut=
e Source.
+ * Redistribution of source code of any substantial portion of the C=
overed
+ * Code or modification without rights to further distribute source =
must
+ * include the following Disclaimer and Export Compliance provision =
in the
+ * documentation and/or other materials provided with distribution. =
 In
+ * addition, Licensee may not authorize further sublicense of source=
 of any
+ * portion of the Covered Code, and must include terms to the effect=
 that the
+ * license from Licensee to its licensee is limited to the intellect=
ual
+ * property embodied in the software Licensee provides to its licens=
ee, and
+ * not to intellectual property embodied in modifications its licens=
ee may
+ * make.
+ *
+ * 3.3. Redistribution of Executable. Redistribution in executable f=
orm of any
+ * substantial portion of the Covered Code or modification must repr=
oduce the
+ * above Copyright Notice, and the following Disclaimer and Export C=
ompliance
+ * provision in the documentation and/or other materials provided wi=
th the
+ * distribution.
+ *
+ * 3.4. Intel retains all right, title, and interest in and to the O=
riginal
+ * Intel Code.
+ *
+ * 3.5. Neither the name Intel nor any other trademark owned or cont=
rolled by
+ * Intel shall be used in advertising or otherwise to promote the sa=
le, use or
+ * other dealings in products derived from or relating to the Covere=
d Code
+ * without prior written authorization from Intel.
+ *
+ * 4. Disclaimer and Export Compliance
+ *
+ * 4.1. INTEL MAKES NO WARRANTY OF ANY KIND REGARDING ANY SOFTWARE P=
ROVIDED
+ * HERE.  ANY SOFTWARE ORIGINATING FROM INTEL OR DERIVED FROM INTEL =
SOFTWARE
+ * IS PROVIDED "AS IS," AND INTEL WILL NOT PROVIDE ANY SUPPORT,  ASS=
ISTANCE,
+ * INSTALLATION, TRAINING OR OTHER SERVICES.  INTEL WILL NOT PROVIDE=
 ANY
+ * UPDATES, ENHANCEMENTS OR EXTENSIONS.  INTEL SPECIFICALLY DISCLAIM=
S ANY
+ * IMPLIED WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT AND FITNES=
S FOR A
+ * PARTICULAR PURPOSE.
+ *
+ * 4.2. IN NO EVENT SHALL INTEL HAVE ANY LIABILITY TO LICENSEE, ITS =
LICENSEES
+ * OR ANY OTHER THIRD PARTY, FOR ANY LOST PROFITS, LOST DATA, LOSS O=
F USE OR
+ * COSTS OF PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, OR FOR ANY =
INDIRECT,
+ * SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THIS AGREEMENT, U=
NDER ANY
+ * CAUSE OF ACTION OR THEORY OF LIABILITY, AND IRRESPECTIVE OF WHETH=
ER INTEL
+ * HAS ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES.  THESE LIM=
ITATIONS
+ * SHALL APPLY NOTWITHSTANDING THE FAILURE OF THE ESSENTIAL PURPOSE =
OF ANY
+ * LIMITED REMEDY.
+ *
+ * 4.3. Licensee shall not export, either directly or indirectly, an=
y of this
+ * software or system incorporating such software without first obta=
ining any
+ * required license or other approval from the U. S. Department of C=
ommerce or
+ * any other agency or department of the United States Government.  =
In the
+ * event Licensee exports any such software from the United States o=
r
+ * re-exports any such software from a foreign destination, Licensee=
 shall
+ * ensure that the distribution and export/re-export of the software=
 is in
+ * compliance with all laws, regulations, orders, or other restricti=
ons of the
+ * U.S. Export Administration Regulations. Licensee agrees that neit=
her it nor
+ * any of its subsidiaries will export/re-export any technical data,=
 process,
+ * software, or service, directly or indirectly, to any country for =
which the
+ * United States government or any agency thereof requires an export=
 license,
+ * other governmental approval, or letter of assurance, without firs=
t obtaining
+ * such license, approval or letter.
+ *
+ *******************************************************************=
**********/
+
+
+#ifndef THERMALPAGE_H
+#define THERMALPAGE_H
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/time.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/un.h>  //include for domain type AF_UNIX
+#include <netinet/in.h>  //Used for domain type AF_INET
+#include <arpa/inet.h>=20
+#include <stdlib.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <ctype.h>
+
+#include <qobject.h>
+#include <qwidget.h>
+#include <qcolor.h>
+#include <qabstractlayout.h>
+#include <qlayout.h>
+#include <qlabel.h>
+#include <qstring.h>
+#include <qbutton.h>
+#include <qpushbutton.h>
+#include <qgroupbox.h>
+#include <qrangecontrol.h>
+#include <qslider.h>
+#include <qcombobox.h>
+#include <qpalette.h>
+#include <qmessagebox.h>
+
+#include "power.h"
+
+
+class ThermalPage : public QWidget
+{
+=09Q_OBJECT
+
+ public:
+=09ThermalPage(QWidget *parent, const char *name=3D0 );
+=09~ThermalPage();
+
+ private:
+=09PM_THERMAL_DATA data;
+
+=09QComboBox *cbZoneKey;
+=09
+=09QFont *qfFont;
+=09QLabel *qlIntro;
+=09QString *qsIntro;
+
+=09QLabel *qlZK;
+=09QString *qsZK;
+=09
+=09QLabel *qlCM;
+=09QString *qsCM;
+
+=09QLabel *qlPF;
+=09QString *qsPF;
+
+=09QLabel *qlST;
+=09QString *qsST;
+
+=09QLabel *qlTP;
+=09QString *qsTP;
+
+};
+
+#endif
+


--Boundary_(ID_NS8L3YY3TBOgDvLOHWH18Q)--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
