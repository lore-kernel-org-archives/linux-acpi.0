From: Yokota Hiroshi <yokota-clLcdqhGaiqhL56FKahb/Dp3QUdN9ktZ@public.gmane.org>
Subject: proc fs interface template for "seq_file.h"
Date: Sat, 02 Oct 2004 17:32:32 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041002.173232.74723807.yokota@netlab.is.tsukuba.ac.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

 Hi. I'm working on "pcc_acpi", and I use "linux/seq_file.h" for
proc fs interface that uses "pcc_acpi".

 Seq file interface is simple and nice. But there is one
inconvenience about "struct file_operations". Seq file must have one
"struct file_operations" and its similar open fs function for each
file. This is the one deplorable point of the seq interface.

 So, I make and propose seq file interface template. This template
creates "struct file_operations", open fs function, and some
function prototypes from one preprocessor macro.

 And I make "seq template" version of ACPI "ac", "button", "power",
"processor", "thermal" and also "toshiba_acpi" driver.

 I wish my proposal makes your help.
And my files can available from:

http://www.netlab.is.tsukuba.ac.jp/~yokota/izumi/panasonic_acpi/
http://www.netlab.is.tsukuba.ac.jp/~yokota/archive/pcc_acpi-0.8-hy20040929.tar.gz

---
E-mail: yokota (at) netlab (dot) is (dot) tsukuba (dot) ac (dot) jp
WWW:    http://www.netlab.is.tsukuba.ac.jp/~yokota/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
