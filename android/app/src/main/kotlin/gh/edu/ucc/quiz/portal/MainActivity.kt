package gh.edu.ucc.quiz.portal

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // use secure flags on Android
        window.addFlags(android.view.WindowManager.LayoutParams.FLAG_SECURE)
    }
}
