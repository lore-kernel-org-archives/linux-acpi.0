From: masc <masc-y2ntbsqpbL5kvIbmRjWsil6hYfS7NtTn@public.gmane.org>
Subject: fan control and polling frequency
Date: Tue, 13 Sep 2005 20:56:38 +0200
Message-ID: <1126637798.4326.6.camel@christl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

hi!

i had for some years problems with the fan control. after reading some
postings i found out that the thermal cooling starts because no
temperature event was sent (temperature events work sometimes, stop
somewhen, ...). activating the polling_frequency (thanks again to the
list) returns to normal fan control. 
is there anything i can do with the dsdt (i have a patched one, thanks
to bruno ducrot -> maxdata pro650T)? may i use a kernel boot option for
activating the polling frequency? 

bye...masc.


-- 
masc <masc-y2ntbsqpbL5kvIbmRjWsil6hYfS7NtTn@public.gmane.org>
theaterzentrum deutschlandsberg



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
